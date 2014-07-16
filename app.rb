Bundler.require

require 'sinatra/asset_pipeline'
require 'sinatra/contrib/all'
require_relative 'lib/deep_symbolize'

def load(name)
  hash = YAML::load_file(File.join(__dir__, "data/#{name}.yml"))
  hash.extend DeepSymbolizable
  hash.deep_symbolize { |key| key }
end

CITIES = load(:cities)
SESSIONS = load(:sessions)

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

  get '/staff' do
    erb :staff
  end

  get '/alumni' do
    erb :alumni
  end

  get '/premiere' do
    redirect to('/programme')
  end

  get '/programme' do
    erb :programme
  end

  get '/partenaires' do
    erb :partenaires
  end

  get '/contact' do
    erb :contact
  end

  get '/postuler' do
    erb :postulate
  end

  get '/faq' do
    erb :faq
  end

  get '/postuler/*' do |product, city|
    @city = CITIES[city.to_sym]
    erb :postulate_city
  end

  # TODO: Mount /blog with jekyll
  # http://derekeder.com/blog/hello-world-setting-up-a-jekyll-blog-in-sinatra

  get '/*' do |path|
    path = path.downcase.to_sym
    if @city = CITIES[path]
      erb :city
    else
      raise Sinatra::NotFound.new
    end
  end
end
