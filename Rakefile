unless ENV['RACK_ENV'] == 'production'
  require 'dotenv'
  Dotenv.load
end

namespace :trello do
  task :boards do
    Trello.configure do |config|
      config.developer_public_key = ENV['TRELLO_API_KEY']
      config.member_token = ENV['TRELLO_API_MEMBER_TOKEN']
    end

    WAGON_TRELLO_ORG_ID = '53621ecf40984f5615bf702a'

    Trello::Board.all.select { |b| b.organization_id == WAGON_TRELLO_ORG_ID } .each do |board|
      puts "# #{board.name}"
      board.lists.each do |list|
        puts "  #{list.id} - #{list.name}"
      end
      puts ""
    end
  end
end

require 'sinatra/asset_pipeline/task'
require './app'

Sinatra::AssetPipeline::Task.define! App