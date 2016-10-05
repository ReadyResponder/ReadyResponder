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
    department 'Police'
  end
end
