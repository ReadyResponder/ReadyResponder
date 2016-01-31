# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :move do
    item_id 1
    locatable_id 1
    locatable_type "MyString"
    comments "MyString"
    reason "MyString"
  end
end
