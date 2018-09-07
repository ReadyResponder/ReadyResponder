# Read about factories at https://github.com/thoughtbot/factory_bot_rails

FactoryBot.define do
  factory :activity do
    content "MyString"
    author "MyString"
    loggable_id 1
    loggable_type "MyString"
  end
end
