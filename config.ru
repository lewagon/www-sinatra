require 'rack/cors'

Encoding.default_external = "utf-8"

use Rack::Cors do
  allow do
    origins '*'
    resource '/assets/*', :headers => :any, :methods => :get
  end
end

require 'rack/deflater'
use Rack::Deflater

require 'rack/contrib'
use Rack::Locale

require './app'
run App
