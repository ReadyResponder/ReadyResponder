FactoryGirl.define do
  factory :message do
    subject "test subject"
    status "Sent"
    body "This is a test message!"
    sent_at 2.hours.ago
    association :recipient, factory: :recipient
    association :channel, factory: :channel
  end
end
