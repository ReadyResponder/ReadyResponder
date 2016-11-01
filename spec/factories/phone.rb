FactoryGirl.define do
  factory :phone do
    name "Main Phone"
    content "9785551212"
    priority 1
    category "Mobile"
    carrier "Sprint"
    last_verified "2013-01-06 01:30:46"
    usage "All"
    person
  end
end
