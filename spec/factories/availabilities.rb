FactoryGirl.define do
  factory :availability do
    association :person
    start_time Time.now
    end_time 15.hours.from_now
    status "Unavailable"
    description "Vacation"
  end
end
