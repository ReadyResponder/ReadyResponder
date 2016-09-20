FactoryGirl.define do
  factory :availability do
    start_time Time.now
    end_time 15.hours.from_now
    status "Unavailable"
    comments "Vacation"
  end
end
