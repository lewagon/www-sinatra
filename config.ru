require 'rack/cors'
use Rack::Cors do
  allow do
    origins '*'
    resource '/assets/*', :headers => :any, :methods => :get
  end
end

require 'rack/deflater'
use Rack::Deflater

require './app'
run App