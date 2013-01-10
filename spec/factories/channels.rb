# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :channel do
    name "Main Phone"
    content "(978) 555-1212"
    priority 1
    category "Mobile"
    carrier "Sprint"
    last_verified "2013-01-06 01:30:46"
    usage "All"
    person
  end
end
