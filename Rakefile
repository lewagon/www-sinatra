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

require 'csv'
CSV_FILE = 'students.csv'

namespace :trello do
  task :emails do
    Trello.configure do |config|
      config.developer_public_key = ENV['TRELLO_API_KEY']
      config.member_token = ENV['TRELLO_API_MEMBER_TOKEN']
    end

    WAGON_TRELLO_ORG_ID = '53621ecf40984f5615bf702a'

    Trello::Board.all.select { |b| b.organization_id == WAGON_TRELLO_ORG_ID } .each do |board|
      board.lists.each do |list|
        if list.name.match(/\AGO/)
          puts "extracting #{list.cards.count} emails from list #{list.name}.."
          CSV.open(CSV_FILE, 'a') do |csv|
            list.cards.each do |card|
              csv << [card.name, list.name]
            end
          end
        end
      end
    end
  end
end

require 'sinatra/asset_pipeline/task'
require './app'

Sinatra::AssetPipeline::Task.define! App