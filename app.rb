require 'bundler'
Bundler.require

require 'sinatra/asset_pipeline'
require 'sinatra/content_for'

require_relative 'lib/data'
require_relative 'lib/blog'

class App < Sinatra::Base
  set :assets_precompile, %w(app.js app.css wufoo.css *.png *.jpg *.svg *.otf *.eot *.ttf *.woff)

  register Sinatra::AssetPipeline
  helpers Sinatra::ContentFor

  configure :development do
    require 'better_errors'
    use BetterErrors::Middleware
  end

  configure :production do
    require 'sinatra/cacher'
    register Sinatra::Cache
    set :cache_enabled, true
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
