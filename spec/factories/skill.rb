FactoryGirl.define do
  factory :skill do
    status "Active"
    sequence (:name) {|n|  "Skill#{n}" }
  end
end
