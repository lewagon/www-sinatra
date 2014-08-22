require "trello"

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_API_KEY']
  config.member_token = ENV['TRELLO_API_MEMBER_TOKEN']
end

class RegisterApplication
  def run(params)
    card = Trello::Card.new
    card.name = params[:email]
    card.list_id = "TODO TRELLO BOARD LIST ID"
    card.desc = <<-EOF## Infos
#{params[:name]} | #{params[:age]} | #{params[:email]}

## Motivation

#{params[:why]}
EOF

    card.save
  end
end