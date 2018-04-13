FactoryGirl.define do
  factory :department do
    sequence(:name) { |n| "Medical Reserve Corps #{n}"}
    shortname "MRC"
    manage_people true
    status "Active"
    contact_id 1
    description "Large Organization"
  end

end
