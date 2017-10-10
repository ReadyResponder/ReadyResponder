FactoryGirl.define do
  factory :timecard do
    start_time 1.hour.ago
    end_time 1.hour.from_now
    status "Verified"
  end
end
