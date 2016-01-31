FactoryGirl.define do
  factory :email do
    content 'sierra@example.com'
    priority 1
    category 'E-Mail'
    last_verified "2013-01-06 01:30:46"
    usage "All"
    person
  end
end
