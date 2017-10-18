FactoryGirl.define do
  factory :person do
    firstname "CJ"
    sequence (:lastname) {|n| "Doe#{n}" }
    sequence (:icsid) {|n| "50#{n}" }
    status "Active"
    start_date Date.yesterday
    division1 'Command'
    division2 'Command'
    title 'Captain'
    gender 'Female'
    association :department, factory: :department
  
    factory :active_person do
    end

    factory :inactive_person do
      status "Inactive"
    end
  end
end
