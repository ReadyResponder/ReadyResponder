FactoryBot.define do
  factory :message do
    subject "test subject"
    status "Sent"
    body "This is a test message!"
    sent_at 2.hours.ago
  end
end
