require 'rubygems'
require 'bundler'
Bundler.require

require 'sinatra/asset_pipeline'
require 'sinatra/content_for'
require 'autoprefixer-rails'

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

  register Sinatra::AssetPipeline
  helpers Sinatra::ContentFor

  configure :development do
    require 'better_errors'
    use BetterErrors::Middleware
  end

  get '/' do
    erb :index
  end

  %w(profs presse partenaires).each do |slug|
    get "/#{slug}" do
      redirect to('/')
    end
  end

  get '/premiere' do
    redirect to('/programme')
  end

  %i(staff alumni programme partenaires contact faq).each do |slug|
    get "/#{slug}" do
      erb slug
    end
  end

  get '/postuler' do
    erb :postulate
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

  CITIES.each do |slug, city|
    get "/#{slug}" do
      @city = city
      erb :city
    end
  end
end
