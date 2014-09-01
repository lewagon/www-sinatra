module UseCases

  class SubscribeToNewsletter
    def initialize
      @gb = Gibbon::API.new ENV['MAILCHIMP_API_KEY']
      @list_id = ENV['MAILCHIMP_LIST_ID']
    end

    def run(params)
      @gb.lists.subscribe({
        :id => @list_id,
        :email => { :email => params[:email] },
        :merge_vars => params[:city] ? {:CITY => params[:city]} : {},
        :double_optin => false
      })
    end
  end

end