require 'rubygems'
require 'bundler'
Bundler.require

require 'sinatra/asset_pipeline'
require 'sinatra/content_for'
require 'autoprefixer-rails'

require 'i18n'

require_relative 'lib/data'
require_relative 'lib/blog'

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
  set :assets_precompile, %w(app.js app.css wufoo.css *.png *.jpg *.svg *.otf *.eot *.ttf *.woff)
  set :assets_prefix, assets_prefix
  set :assets_css_compressor, :sass
  set :assets_js_compressor, :uglifier

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
    faq: { view: :faq, path: '/faq' }
  }

  DEFAULT_LOCALE = :fr
  LOCALES = %i(fr en)

  LOCALES.each do |locale|
    if locale == DEFAULT_LOCALE
      get '/' do
        erb :index
      end
    else
      get "/#{locale}" do
        I18n.locale = locale
        erb :index
      end
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

  before do
    unless LOCALES.include?(I18n.locale)  # Detected by Rack::Locale
      I18n.locale = DEFAULT_LOCALE
    end
  end

  get '/premiere' do
    redirect '/programme', 301
  end

  get '/blog' do
    @posts = Blog.new.all
    erb :blog
  end

  # TODO - change the routing once blog is translated..
  get '/en/blog' do
    @posts = Blog.new.all
    erb :blog
  end

  get '/blog/*' do |slug|
    @post = Blog.new.post(slug)
    halt 404 unless @post
    erb :post
  end

  get '/wufoo.css' do
    content_type "text/css"
    expires 3600, :public, :must_revalidate
    sprockets['wufoo.css'].source
  end

  post '/subscribe' do
    begin
      result = UseCases::SubscribeToNewsletter.new.run(params)
      json :result => result
    rescue Gibbon::MailChimpError
    end
  end

  post '/apply' do
    camp = CAMPS[params[:camp].to_sym]
    params[:city] = camp[:city]  # For the newsletter
    UseCases::PushStudentApplicationToTrello.new(camp[:trello][:inbox_list_id]).run(params)
    begin
      UseCases::SubscribeToNewsletter.new.run(params)
    rescue Gibbon::MailChimpError => e
      puts e
    end
    redirect thanks_path + "?camp=#{params[:camp]}"
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
        @meetup = api.groups(group_id: @city[:meetup_id])["results"].first
        @meetup.extend DeepSymbolizable
        @meetup = @meetup.deep_symbolize { |key| key }
        @meetup_events = api.events(group_id: @city[:meetup_id])["results"].select { |m| m["status"] == "upcoming" }
        @meetup_events = @meetup_events.map do |event|
          event.extend DeepSymbolizable
          event.deep_symbolize { |key| key }
        end
      rescue
        puts "No Meetup Found"
      end
    end
  end
end