FactoryGirl.define do
  factory :notification do
    subject "Urgent: Read Me"
    body "We live in a vacuous world, yet we do so with a feeling of urgency."
    status "Active"
    start_time "2016-09-26 22:21:34"
    channels "Email Text"
  end
end
