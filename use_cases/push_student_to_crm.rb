module UseCases
  class PushStudentToCrm
    def initialize(trello_card)
      @trello_card = trello_card
    end

    def run(params)
      url = "#{ENV['CRM_BASE_URL']}/api/v1/cards"

      payload = {
        card: {
          trello_board_id: @trello_card.board.id,
          trello_card_id: @trello_card.id,
          email: params[:email],
          first_name: params[:first_name],
          last_name: params[:last_name],
          age: params[:age],
          phone_number: params[:phone],
          motivation: params[:motivation]
        }
      }

      begin
        RestClient.post url, payload.to_json,
          content_type: :json,
          accept: :json,
          :'X-CRM-TOKEN' => ENV['CRM_TOKEN']
      rescue Exception => e
        puts e.message
      end
    end
  end
end