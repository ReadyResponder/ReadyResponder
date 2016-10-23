FactoryGirl.define do
  factory :requirement do
    minimum_people 1
    maximum_people 1
    desired_people 1
    floating false
    optional false
  end
end
