require 'bundler'
Bundler.require

require 'sinatra/asset_pipeline'
require 'sinatra/content_for'
require 'yaml'

require_relative 'lib/deep_symbolize'
require_relative 'lib/blog'

def load(name)
  hash = YAML::load_file(File.join(__dir__, "data/#{name}.yml"))
  hash.extend DeepSymbolizable
  hash.deep_symbolize { |key| key }
end

CITIES = load(:cities)

class App < Sinatra::Base
  register Sinatra::AssetPipeline
  helpers Sinatra::ContentFor

  configure :development do
    require 'better_errors'
    register Sinatra::Reloader
    use BetterErrors::Middleware
  end

  get '/' do
    erb :index
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
