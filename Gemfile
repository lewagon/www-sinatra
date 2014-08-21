source "https://rubygems.org"
source 'https://rails-assets.org'
ruby '2.1.2'

gem 'sinatra'
gem 'sinatra-asset-pipeline'
gem 'sinatra-contrib'
gem 'rack-contrib'
gem 'i18n'

gem 'autoprefixer-rails'

group :assets do
  gem 'bootstrap-sass', '~> 3.2.0'
  gem 'rails-assets-jquery'
  gem 'rails-assets-font-awesome'
end

gem 'redcarpet'
gem 'gibbon'

# Serve fonts to other domains (Wufoo)
gem 'rack-cors', :require => 'rack/cors'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rerun'
  gem 'dotenv'
  gem 'pry-byebug'
end

group :production do
  gem 'puma'
  gem 'rails_12factor'
  gem 'uglifier'
end
