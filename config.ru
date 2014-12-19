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

require_relative 'lib/rack/block_referal_spam'
use Rack::BlockReferalSpam

require './app'
run App
