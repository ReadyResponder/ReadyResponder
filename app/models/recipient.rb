class Recipient < ApplicationRecord
  belongs_to :notification, optional: true
  belongs_to :person, optional: true
  has_many :messages

  def notify! twilio = Message::SendNotificationTextMessage.new
    target_number = person.phone
    target_number = "+1#{person.phone}" if /\A\d{10}/.match target_number
    msg = twilio.sms_send notification.subject, target_number

  end
end
