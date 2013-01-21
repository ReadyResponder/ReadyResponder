# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    location_id 1
    name "MyString"
    description "MyString"
    source "MyString"
    category "MyString"
    model "MyString"
    serial "MyString"
    #owner_id 1
    purchase_date "2012-12-14"
    purchase_amt ""
    sell_date "2012-12-14"
    sell_amt ""
    status "MyString"
  end
end
