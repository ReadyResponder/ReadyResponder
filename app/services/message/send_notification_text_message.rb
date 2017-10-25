class Message::SendNotificationTextMessage
  class InvalidClient < StandardError; end
  require 'twilio-ruby'
  def initialize
    # create Twilio Client
    account_sid = Setting.get("TWILIO_ACCOUNT_SID") # Your Account SID from www.twilio.com/console
    auth_token = Setting.get("TWILIO_AUTH_TOKEN")  # Your Auth Token from www.twilio.com/console

    begin
      @client = Twilio::REST::Client.new account_sid, auth_token
    rescue
      return "Unable to authenticate with Twilio"
    end
  end

  def sms_send(message, recipient_number,
           sender_number = Setting.get("outbound_text_number"))
    begin
      raise InvalidClient.new('Invalid Twilio Client') if @client.nil?
      msg = @client.account.messages.create(
                    :body => message,
                    :to => recipient_number,
                    :from => sender_number)
      Rails.logger.warn "Sent text message: #{msg.inspect}"
      return msg
    rescue Twilio::REST::RequestError => e
      return e
    end
  end
end
