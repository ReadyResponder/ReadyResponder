FactoryGirl.define do
  factory :item_category do
    sequence (:name) {|n| "Item category#{n}" }
    status "Active"
    description "A place for my stuff"
    department nil
  end
end
