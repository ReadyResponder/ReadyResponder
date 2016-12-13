class Message::SendNotificationTextMessage
  require 'twilio-ruby'
  def initialize
    # create Twilio Client
    account_sid = ENV["TWILIO_ACCOUNT_SID"] # Your Account SID from www.twilio.com/console
    auth_token = ENV["TWILIO_AUTH_TOKEN"]   # Your Auth Token from www.twilio.com/console

    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def call(message, recipient_number, sender_number)
    begin
        message = @client.account.messages.create(:body => message,
            :to => recipient_number,
            :from => sender_number)
        Rails.logger.info "Sent text message: #{message.inspect}"
        return message
    rescue Twilio::REST::RequestError => e
        puts e.message
    end
  end
end
