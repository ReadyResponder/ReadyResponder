# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    content "MyString"
    author "MyString"
    loggable_id 1
    loggable_type "MyString"
  end
end
