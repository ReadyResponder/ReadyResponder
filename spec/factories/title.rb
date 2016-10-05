FactoryGirl.define do
  factory :title do
    status "Active"
    sequence (:name) {|n|  "Skill#{n}" }
  end
end
