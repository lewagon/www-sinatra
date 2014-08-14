require 'rubygems'
require 'bundler'
Bundler.require

require 'sinatra/asset_pipeline'
require 'sinatra/content_for'
require 'autoprefixer-rails'

require 'i18n'

require_relative 'lib/data'
require_relative 'lib/blog'

class App < Sinatra::Base
  sprockets = Sprockets::Environment.new
  AutoprefixerRails.install(sprockets)

  assets_prefix = %w(assets vendor/assets) + (Bundler.definition.dependencies.map do |dep|
    if dep.groups.include? :assets
      [ [dep.to_spec.full_gem_path, 'vendor', 'assets'].join('/'), [dep.to_spec.full_gem_path, 'assets'].join('/') ]
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

  PAGES = {
    apply: { view: :postuler, locale_path: { en: '/apply', fr: '/postuler' }},
    program: { view: :programme, locale_path: { en: '/program', fr: '/programme' }},
    alumni: { view: :alumni, path: '/alumni' },
    faq: { view: :faq, path: '/faq' }
  }

  DEFAULT_LOCALE = :fr
  LOCALES = %i(fr en)
  AUTOMATIC_LOCALE_ROOT_REDIRECT = true   # TODO: enable this only when ALL pages are localized

  LOCALES.each do |locale|
    if locale == DEFAULT_LOCALE
      get '/' do
        if AUTOMATIC_LOCALE_ROOT_REDIRECT
          if I18n.locale != DEFAULT_LOCALE  # I18n.locale detected by Rack::Locale
            redirect "/#{I18n.locale}", 302
          else
            erb :index
          end
        else
          erb :index
        end
      end
    else
      get "/#{locale}" do
        I18n.locale = locale
        erb :index
      end
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
      I18n.locale = city_locale
      erb :city
    end

    LOCALES.each do |locale|
      if locale != city_locale
        get "/#{locale}/#{slug}" do
          @city = city
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
    gb = Gibbon::API.new(ENV['MAILCHIMP_API_KEY'])
    begin
      result = gb.lists.subscribe({
        :id => ENV['MAILCHIMP_LIST_ID'],
        :email => {:email => params[:email]},
        :merge_vars => params[:city] ? {:CITY => params[:city]} : {},
        :double_optin => false
        })
      json :result => result
    rescue Gibbon::MailChimpError
    end
  end

  not_found do
    redirect "/"
  end

  helpers do
    def t(*args)
      I18n.t(*args)
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
          base_path = locale == DEFAULT_LOCALE ? '' : locale
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
          if page[:path] == request.path
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
end
