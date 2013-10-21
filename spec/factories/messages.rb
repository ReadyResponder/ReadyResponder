# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    subject "MyString"
    status "MyString"
    body "MyString"
    channels "MyString"
    sent_at "2013-10-21 08:06:58"
    created_by 1
  end
end
