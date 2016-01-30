# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :repair do
    item_id 1
    user_id 1
    person_id 1
    category "MyString"
    service_date "2012-12-14"
    status "MyString"
    description "MyString"
    cost 1100
    comments "MyString"
  end
end
