FactoryGirl.define do
  factory :event do
    title "A Training Event"
    category "Training"
    status "Scheduled"
    start_time Time.now
    end_time 23.hours.from_now
  end
end
