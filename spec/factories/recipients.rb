FactoryGirl.define do
  factory :recipient do
    association :notification, factory: :notification
    association :person, factory: :person
    status "Acknowledged"
    response_channel "E-mail"
    response_time 2.hours.ago
  end
end
