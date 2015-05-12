unless ENV['RACK_ENV'] == 'production'
  require 'dotenv'
  Dotenv.load
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require "trello"

WAGON_TRELLO_ORG_ID = '53621ecf40984f5615bf702a'
def configure_trello
  Trello.configure do |config|
    config.developer_public_key = ENV['TRELLO_API_KEY']
    config.member_token = ENV['TRELLO_API_MEMBER_TOKEN']
  end
end

namespace :trello do
  task :status do
    configure_trello

    Trello::Board.all.select { |b| b.organization_id == WAGON_TRELLO_ORG_ID } .each do |board|
      next if board.lists.first.name != "INBOX"
      next if board.name =~ /2014/
      probabilities = { 'INBOX' => 0.1, 'FIRST CONTACT' => 0.2, 'INTERVIEW' => 0.5, 'CODECADEMY' => 0.6, 'OPCA' => 0.7, 'CONTRAT' => 0.8, 'ACOMPTE' => 0.9, 'GO' => 1 }
      students = board.lists.reduce(0) do |sum, list|
        sum + (probabilities[list.name] || 0) * list.cards.size
      end
      puts "# #{board.name}: #{students.round(1)} students"
    end
  end

  task :boards do
    configure_trello

    Trello::Board.all.select { |b| b.organization_id == WAGON_TRELLO_ORG_ID } .each do |board|
      puts "# #{board.name} (#{board.id})"
      board.lists.each do |list|
        puts "  #{list.id} - #{list.name}"
      end
      puts ""
    end
  end

  task :no_go_emails do
    configure_trello

    no_go_emails = emails(/\ANO GO/)
    go_emails = emails(/\AGO/)
    puts no_go_emails - go_emails
  end

  def emails(list_regex)
    emails = []
    Trello::Board.all.select { |b| b.organization_id == WAGON_TRELLO_ORG_ID } .each do |board|
      board.lists.each do |list|
        if list.name.match(list_regex)
          list.cards.each do |card|
            emails << card.name
          end
        end
      end
    end
    emails.uniq
  end
end

require 'sinatra/asset_pipeline/task'
require './app'

Sinatra::AssetPipeline::Task.define! App
