FactoryGirl.define do
  factory :inspection do
    person
    item
    inspection_date Date.tomorrow.strftime('%Y-%m-%d')
    status "Passed"
  end
end
