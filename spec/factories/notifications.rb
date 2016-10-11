FactoryGirl.define do
  factory :notification do
    status "sent"
    started_at "2016-09-26 22:21:34"
    channels "Email Text"
  end
end
