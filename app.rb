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
PRODUCTS = load(:products)
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

  get '/evenements' do
    erb :evenements
  end

  get '/staff' do
    erb :staff
  end

  get '/alumni' do
    erb :alumni
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

  get '/postuler/*/*' do |product, city|
    @product = PRODUCTS[product.to_sym]
    @city = CITIES[city.to_sym]
    erb :postulate_product_city
  end

  get '/*/*' do |product, city|
    @product = PRODUCTS[product.to_sym]
    @city = CITIES[city.to_sym]
    erb :product_city
  end

  # TODO: Mount /blog with jekyll
  # http://derekeder.com/blog/hello-world-setting-up-a-jekyll-blog-in-sinatra

  get '/*' do |path|
    path = path.downcase.to_sym
    if @city = CITIES[path]
      erb :city
    elsif @product = PRODUCTS[path]
      erb :product
    else
      raise Sinatra::NotFound.new
    end
  end
end
