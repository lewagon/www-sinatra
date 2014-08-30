require "trello"

module UseCases
  class PushStudentApplicationToTrello
    def initialize(trello_inbox_list_id)
      @trello_inbox_list_id = trello_inbox_list_id

      Trello.configure do |config|
        config.developer_public_key = ENV['TRELLO_API_KEY']
        config.member_token = ENV['TRELLO_API_MEMBER_TOKEN']
      end
    end

    def run(params)
      card = ::Trello::Card.new
      card.name = params[:email]
      card.list_id = @trello_inbox_list_id
      card.desc = <<-EOF
## Infos
#{params[:first_name]} #{params[:last_name]} | #{params[:age]} | #{params[:email]}

## Motivation

#{params[:motivation]}
  EOF

      card.save
    end
  end
end