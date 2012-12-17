# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    course_id 1
    instructor "MyString"
    location "MyString"
    description "MyString"
    start_date "2012-12-14 05:50:18"
    end_date "2012-12-14 05:50:18"
    duration 1
    category "MyString"
    status "MyString"
  end
end
