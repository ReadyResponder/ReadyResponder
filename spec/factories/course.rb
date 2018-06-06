FactoryBot.define do
  factory :course do
    status "Active"
    sequence (:name) {|n| "Course#{n}" }
  end
end
