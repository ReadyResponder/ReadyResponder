FactoryGirl.define do
  factory :department do
    name "Medical Reserve Corps"
    shortname "MRC"
    manage_people true
    status "Active"
    contact_id 1
    description "Large Organization"
  end

end
