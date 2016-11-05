FactoryGirl.define do
  factory :notification do
    subject "An Important Title"
    body "A devastating message, which is very significant."
    status "active"
    start_time "2016-09-26 22:21:34"
    channels "email text"
  end
end
