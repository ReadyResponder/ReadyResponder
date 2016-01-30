# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    name "MyString"
    description "MyString"
    category "MyString"
    status "MyString"
    comments "MyString"
    lat ""
    lon ""
  end
end
