FactoryGirl.define do
  factory :timecard do
    person
    start_time "2013-12-23 03:31"
    end_time "2013-12-23 04:31"
    status "Verified"
  end
end
