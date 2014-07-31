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

  configure :development do
    require 'better_errors'
    use BetterErrors::Middleware
    require 'dotenv'
    Dotenv.load
    I18n.load_path = Dir[File.join(settings.root, 'locales', '*.yml')]
    before do
      I18n.backend.reload!
    end
  end

  before do
    I18n.locale = :fr  # Default
  end

  get '/' do
    erb :index
  end

  get '/premiere' do
    redirect '/programme', 301
  end

  %i(staff alumni programme partenaires contact faq postuler).each do |slug|
    get "/#{slug}" do
      erb slug
    end
  end

  get '/blog' do
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

  CITIES.each do |slug, city|
    get "/#{slug}" do
      @city = city
      I18n.locale = city[:locale].to_sym
      erb :city
    end
  end

  not_found do
    redirect "/"
  end

  helpers do
    def t(*args)
      I18n.t(*args)
    end
  end
end
