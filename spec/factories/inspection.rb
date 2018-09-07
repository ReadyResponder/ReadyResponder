FactoryBot.define do
  factory :inspection do
    item_id 1
    inspection_date Date.tomorrow.strftime('%Y-%m-%d')
    status "Passed"
  end
end
