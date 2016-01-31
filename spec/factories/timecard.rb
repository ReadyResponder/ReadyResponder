FactoryGirl.define do
  factory :timecard do
    person
    event
    category "Training"
    intended_start_time "2013-12-23 03:31"
    intended_end_time "2013-12-23 04:31"
    intention "Volunteered"
    #I don't want anything in a factory that isn't needed to make a valid object
    #actual_start_time "2012-12-23 03:31"
    #actual_end_time "2012-12-23 05:31"
    #outcome "Actual"
  end
end
