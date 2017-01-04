class Recipient < ActiveRecord::Base
  belongs_to :notification
  belongs_to :person
  has_many :messages

  def notify! twilio = Message::SendNotificationTextMessage.new
    target_number = person.phone
    target_number = "+1#{person.phone}" if /\A\d{10}/ === target_number
    msg = twilio.sms_send notification.subject, target_number

  end
end
