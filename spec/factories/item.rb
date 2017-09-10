# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name "EMA-10"
    description "Ford F-150"
    source "Main Street Ford"
    category "Vehicle"
    qty 1
    brand 'Ford'
    model "F-150"
    purchase_date "2010-12-14"
    purchase_amt ""
    status "Available"
    value 655.32
    association :owner, factory: :person
    location
  end
end
