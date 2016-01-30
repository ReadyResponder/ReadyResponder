FactoryGirl.define do
  factory :role do
    sequence (:name) {|n| "testrole#{n}" }
  end
end
