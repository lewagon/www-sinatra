require 'rubygems'
require 'bundler'
Bundler.require

require 'sinatra/asset_pipeline'
require 'sinatra/content_for'
require 'autoprefixer-rails'

require 'i18n'
require 'builder'

require_relative 'lib/data'
require_relative 'lib/blog'
require_relative 'lib/cache'

require_relative "use_cases/push_student_application_to_trello"
require_relative "use_cases/subscribe_to_newsletter"

class App < Sinatra::Base
  sprockets = Sprockets::Environment.new
  AutoprefixerRails.install(sprockets)

  assets_prefix = %w(assets vendor/assets) + (Bundler.definition.dependencies.map do |dep|
    if dep.groups.include? :assets
      [ [dep.to_spec.full_gem_path, 'vendor', 'assets'].join('/'),
        [dep.to_spec.full_gem_path, 'assets'].join('/'),
        [dep.to_spec.full_gem_path, 'app', 'assets'].join('/') ]
    end
  end.compact.flatten).to_a

  set :sprockets, sprockets
  set :assets_precompile, %w(app.js app.css wufoo.css *.gif *.png *.jpg *.svg *.otf *.eot *.ttf *.woff)
  set :assets_prefix, assets_prefix
  set :assets_host, ENV['CDN_ROOT_URL']
  set :assets_css_compressor, :sass
  set :assets_js_compressor, :uglifier

  if ENV['BUGSNAG_API_KEY']
    Bugsnag.configure do |config|
      config.api_key = ENV['BUGSNAG_API_KEY']
    end
    use Bugsnag::Rack
    error 500 do
    Bugsnag.auto_notify($!)
      erb :"errors/500"
    end
  end

  register Sinatra::AssetPipeline
  helpers Sinatra::ContentFor

  configure do
    I18n.load_path = Dir[File.join(settings.root, 'locales', '*.yml')]
  end

  configure :development do
    require 'better_errors'
    use BetterErrors::Middleware
    require 'dotenv'
    Dotenv.load
    before do
      I18n.backend.reload!
    end
    require "pry-byebug"
  end

  configure do
    require 'action_controller'
    require 'meetup_client'
    MeetupClient.configure do |config|
      config.api_key = ENV['MEETUP_API_KEY']
    end
  end

  PAGES = {
    apply: { view: :postuler, locale_path: { en: '/apply', fr: '/postuler' }},
    thanks: { view: :thanks, locale_path: { en: '/thanks', fr: '/merci' }},
    program: { view: :programme, locale_path: { en: '/program', fr: '/programme' }},
    alumni: { view: :alumni, path: '/alumni' },
    press: { view: :presse, locale_path: { en: '/press', fr: '/presse' }},
    faq: { view: :faq, path: '/faq' },
    jobs: { view: :jobs, path: '/jobs' }
  }

  DEFAULT_LOCALE = :fr
  LOCALES = %i(fr en)

  LOCALES.each do |locale|
    get "/#{locale == DEFAULT_LOCALE ? "" : locale}" do
      I18n.locale = locale
      @city = CITIES[:paris]
      find_meetup
      erb :index
    end
  end

  PAGES[:press][:locale_path].each do |locale, path|
    get path do
      I18n.locale = locale
      @body_class = 'press'
      @press = params[:press] ? PRESS[params[:press].to_sym] : nil
      erb :press
    end
  end

  PAGES[:thanks][:locale_path].each do |locale, path|
    get path do
      I18n.locale = locale
      @camp = params[:camp] ? CAMPS[params[:camp].to_sym] : nil
      erb :thanks
    end
  end

  PAGES.each do |key, info|
    if info[:locale_path]
      info[:locale_path].each do |locale, path|
        get path do
          I18n.locale = locale
          erb info[:view]
        end
      end
    else
      LOCALES.each do |locale|
        base_path = locale == DEFAULT_LOCALE ? '' : "/#{locale}"
        get "#{base_path}#{info[:path]}" do
          I18n.locale = locale
          erb info[:view]
        end
      end
    end
  end

  CITIES.each do |slug, city|
    city_locale = city[:locale].to_sym

    get "/#{slug}" do
      @city = city
      find_meetup
      I18n.locale = city_locale
      erb :city
    end

    LOCALES.each do |locale|
      if locale != city_locale
        get "/#{locale}/#{slug}" do
          @city = city
          find_meetup
          I18n.locale = locale
          erb :city
        end
      end
    end
  end

  BOOSTERS.each do |slug, booster|
    get "/kit/#{slug}" do
      @booster_slug = slug
      @booster = booster
      @booster_camps = BOOSTER_CAMPS.select { |_, camp| camp[:booster] == slug.to_s }
      @city = CITIES[booster[:city].to_sym]
      I18n.locale = :fr
      erb :booster
    end
  end

  before do
    unless LOCALES.include?(I18n.locale)  # Detected by Rack::Locale
      I18n.locale = DEFAULT_LOCALE
    end
  end

  get '/premiere' do
    redirect '/programme', 301
  end

  get '/blog' do
    I18n.locale = :fr
    fetch_posts
    erb :blog
  end

  # TODO - change the routing once blog is translated..
  get '/en/blog' do
    fetch_posts
    erb :blog
  end

  get '/blog/rss.xml' do
    @posts = Blog.new.all
    builder :blog_rss
  end

  get '/blog/*' do |slug|
    I18n.locale = :fr
    @body_class = "blog"
    @post = Blog.new.post(slug)
    halt 404 unless @post
    erb :post
  end

  post '/subscribe' do
    begin
      result = UseCases::SubscribeToNewsletter.new.run(params)
      json :result => result
    rescue Gibbon::MailChimpError => e
      if e.message =~ /is already subscribed to the list/
        json :result => {}
      else
        json :error => e.message
      end
    end
  end

  post '/apply' do
    if params[:camp].blank? || params[:email].blank?
      @error = true
      erb :postuler
    else
      camp = CAMPS[params[:camp].to_sym]
      params[:city] = camp[:city]  # For the newsletter
      UseCases::PushStudentApplicationToTrello.new(camp[:trello][:inbox_list_id]).run(params)
      subscribe_candidate_to_newsletter
      redirect thanks_path + "?camp=#{params[:camp]}"
    end
  end

  post '/booster_apply' do
    if params[:additional_questions]
      questions = params[:additional_questions].values.map { |e| "- #{e[:question]} : #{e[:answer]}" }.join("\n")
      params[:motivation] = [ questions, params[:motivation] ].join("\n\n")
    end

    if params[:booster_camp]
      booster_camp = BOOSTER_CAMPS[params[:booster_camp].to_sym]
      params[:city] = booster_camp[:city]
      UseCases::PushStudentApplicationToTrello.new(booster_camp[:trello][:inbox_list_id]).run(params)
      subscribe_candidate_to_newsletter
      redirect thanks_path + "?kit_camp=#{params[:booster_camp]}"
    elsif params[:booster]
      booster = BOOSTERS[params[:booster].to_sym]
      UseCases::PushStudentApplicationToTrello.new(booster[:trello][:lead_list_id]).run(params)
      subscribe_candidate_to_newsletter
      redirect thanks_path + "?kit_lead=#{params[:booster]}"
    else
      @error = true
      erb :booster
    end
  end

  not_found do
    redirect "/"
  end

  helpers do
    def t(*args)
      I18n.t(*args)
    end

    def l(*args)
      I18n.l(*args)
    end

    def apply_path(options = {})
      fragment = @city ? "##{@city[:next_session_fragment]}" : ""
      (I18n.locale == :fr ? '/postuler' : '/apply') + fragment
    end

    def path(slug, options = {})
      locale = (options[:locale] || I18n.locale).to_sym
      if city = CITIES[slug.to_sym]
        city[:locale].to_sym == locale ? "/#{slug}" : "/#{locale}/#{slug}"
      else
        page = PAGES[slug.to_sym]
        if page[:locale_path]
          page[:locale_path][locale]
        else
          base_path = locale == DEFAULT_LOCALE ? '' : "/#{locale}"
          "#{base_path}#{page[:path]}"
        end
      end
    end

    def current_path(locale)
      PAGES.each do |slug, page|
        if page[:locale_path]
          if page[:locale_path][I18n.locale] == request.path
            return page[:locale_path][locale]
          end
        else
          if /(\/[a-z]+)?#{page[:path]}/ =~ request.path
            return send :"#{slug}_path", locale: locale
          end
        end
      end
      CITIES.each do |slug, city|
        if /(\/[a-z]+)?\/#{slug}/ =~ request.path
          return send :"#{slug}_path", locale: locale
        end
      end
      locale == DEFAULT_LOCALE ? "/" : "/#{locale}"
    end

    # Dynamically rails-style helpers like faq_path, etc.
    (PAGES.merge CITIES).each do |slug, _|
      method = :"#{slug}_path"
      unless self.respond_to? method
        define_method(method) do |*args|
          path(slug, *args)
        end
      end
    end

    def image_url_with_fallback(image_url)
      if image_url.strip.empty?
        "http://www.lewagon.org#{image_path 'social/facebook_card.jpg'}"
      else
        "http://www.lewagon.org#{image_url.strip}"
      end
    end
  end

  alias_method :md, :markdown
  def markdown(content)
    @markdown ||= (
      renderer = Redcarpet::Render::HTML.new
      Redcarpet::Markdown.new(renderer, extensions = {})
    )
    @markdown.render(content)
  end

  private

  def find_meetup
    if @city[:meetup_id]
      begin
        api = MeetupApi.new
        @meetup = $redis.cache("meetup:#{@city[:meetup_id]}", 300) do
          meetup = api.groups(group_id: @city[:meetup_id])["results"].first
          meetup.extend DeepSymbolizable
          meetup.deep_symbolize { |key| key }
        end

        @meetup_events = $redis.cache("meetups:#{@city[:meetup_id]}", 300) do
          meetup_events = api.events(group_id: @city[:meetup_id])["results"].select { |m| m["status"] == "upcoming" }
          meetup_events.map do |event|
            event.extend DeepSymbolizable
            event.deep_symbolize { |key| key }
          end
        end
      rescue Exception => e
        @meetup_events = []
        puts e
      end
    end
  end

  def fetch_posts
    @body_class = "blog"
    # params[:page] = params[:page].nil? ? 1 : params[:page].to_i
    # first = (params[:page] - 1) * 9
    @posts = Blog.new.all#[first...(first + 9)]
  end

  def subscribe_candidate_to_newsletter
    begin
      UseCases::SubscribeToNewsletter.new.run(params)
    rescue Gibbon::MailChimpError => e
      puts e
    end
  end
end
