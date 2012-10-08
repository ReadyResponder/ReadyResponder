FactoryGirl.define do
  #factory :user is located in the factories directory
  factory :person do
    firstname "CJ"
    sequence (:lastname) {|n| "Doe#{n}" }
    status "Active"
    start_date Date.yesterday
    division1 'Command'
    division2 'Command'
    title 'Captain'
  end
  factory :cert do
    status "Active"
    issued_date Date.today
    person
    course
  end
  factory :title do
    status "Active"
    sequence (:name) {|n|  "Skill#{n}" }
  end
  factory :skill do
    status "Active"
    sequence (:name) {|n|  "Skill#{n}" }
  end
  factory :course do
    status "Active"
    sequence (:name) {|n| "Course#{n}" }
  end

end