Bundler.require

require 'sinatra/asset_pipeline'
require 'sinatra/contrib/all'

def load_hash(name)
  YAML::load_file(File.join(__dir__, "data/#{name}.yml")).inject({}){ |h,(k,v)| h[k] = OpenStruct.new(v); h }
end

def load_array(name)
  YAML::load_file(File.join(__dir__, "data/#{name}.yml")).map { |obj| OpenStruct.new(obj) }
end

CITIES = load_hash(:cities)
PRODUCTS = load_hash(:products)
SESSIONS = load_array(:sessions)

class App < Sinatra::Base
  register Sinatra::AssetPipeline
  helpers Sinatra::ContentFor

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  get '/postuler' do

  end

  get '/evenements' do
    erb :evenements
  end

  get '/*' do |path|
    path.downcase!
    if @city = CITIES[path]
      erb :city
    elsif @product = PRODUCTS[path]
      erb :product
    else
      [404, headers, ""]
    end
  end
end