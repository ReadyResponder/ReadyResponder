# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attendance do
    person_id 1
    event_id 1
    category "MyString"
    est_start_time "2012-12-23 03:31:31"
    start_time "2012-12-23 03:31:31"
    est_end_time "2012-12-23 03:31:31"
    end_time "2012-12-23 03:31:31"
    duration "9.99"
  end
end
