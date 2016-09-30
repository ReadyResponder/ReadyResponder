FactoryGirl.define do
  factory :inspection do
    association :item
    inspection_date Date.tomorrow.strftime('%Y-%m-%d')
    status "Passed"
  end
end
