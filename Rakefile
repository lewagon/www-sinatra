unless ENV['RACK_ENV'] == 'production'
  require 'dotenv'
  Dotenv.load
end

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
      puts "# #{board.name}"
      board.lists.each do |list|
        puts "  #{list.id} - #{list.name}"
      end
      puts ""
    end
  end

  task :create_camp do
    configure_trello

    STDOUT.puts "What's the new Trello board name?"
    STDOUT.print "> "
    board_name =  STDIN.gets.chomp

    board = Trello::Board.all.select { |b| b.name == board_name } .first
    if board.nil?
      board = Trello::Board.create(name: board_name, organization_id: WAGON_TRELLO_ORG_ID)
      puts "Just created new board, id = #{board.id}"
    end
    board.lists.map &:close!

    ["FIRST CONTACT", "INTERVIEW", "CODECADEMY", "OPCA", "CONTRAT", "ACOMPTE", "GO", "LEAD FUTUR", "NO GO"].reverse.each do |list_name|
      Trello::List.create(name: list_name, :board_id => board.id)
    end
    inbox_list = Trello::List.create(name: "INBOX", :board_id => board.id)

    puts "TODO, manually:"
    puts "1. Go to #{board.url} and set visibility to 'Organization' instead of 'Private'"
    puts "2. Invite to the Trello board Romain, Charlotte and others"
    puts "3. Add the camp to data/camps.yml or data/boostrer_camps.yml (inbox_list_id: #{inbox_list.id})"
    puts "4. Add zap 'Envoi RDV' (INBOX -> FIRST CONTACT)"
    puts "5. Add zap 'Email CodeCademy' (FIRST CONTACT -> CODE CADEMY)"
    puts "6. Go to https://teamwagon.slack.com/services and add Trello/Slack integration"
  end

  task :emails do
    require 'csv'
    CSV_FILE = 'students.csv'

    configure_trello

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