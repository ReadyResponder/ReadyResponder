class Recipient < ActiveRecord::Base
  belongs_to :notification
  belongs_to :person
  has_many :messages

  def notify! twilio = Message::SendNotificationTextMessage.new
    target_number = person.phone
    target_number = "+1#{person.phone}" if /\A\d{10}/.match target_number
    msg = twilio.sms_send notification.subject, target_number
    if msg.is_a? Twilio::REST::RequestError
      messages.create(status: "error", body: msg.message, channel: person.phone)
    else
      messages.create(status: msg.status, body: msg.body, channel: person.phone)
    end
  end
end
