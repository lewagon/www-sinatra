Bundler.require

require 'sinatra/asset_pipeline'
require 'sinatra/contrib/all'

def load_data(name)
  YAML::load_file(File.join(__dir__, "data/#{name}.yml")).map { |obj| OpenStruct.new(obj) }
end

CITIES = load_data(:cities)
PRODUCTS = load_data(:products)

class App < Sinatra::Base
  register Sinatra::AssetPipeline
  helpers Sinatra::ContentFor

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  get '/*' do |path|
    path.downcase!
    if CITIES.map(&:slug).include?(path)
      @city = CITIES.first { |c| c.slug == path }
      erb :city
    elsif PRODUCTS.map(&:slug).include?(path)
      @product = PRODUCTS.first { |p| p.slug == path}
      erb :product
    else
      [404, headers, ""]
    end
  end
end