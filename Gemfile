source "https://rubygems.org"
ruby '2.2.2'

gem 'sinatra'
gem 'sinatra-asset-pipeline'
gem 'sinatra-contrib'
gem 'rack-contrib'
gem 'i18n'
gem 'builder'
gem 'redis'

gem 'bootstrap-sass', '~> 3.2.0', group: :assets
gem 'autoprefixer-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-jquery', group: :assets
  gem 'rails-assets-font-awesome', group: :assets
end

gem 'pygmentize'
gem 'redcarpet'
gem 'gibbon'
gem 'ruby-trello', github: 'jeremytregunna/ruby-trello'
gem 'rest-client'

# Serve fonts to other domains (Wufoo)
gem 'rack-cors', :require => 'rack/cors'

gem 'bugsnag'
gem 'actionpack'
gem 'meetup_client'

gem 'rspec'

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
