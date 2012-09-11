FactoryGirl.define do
  factory :person do
    firstname "CJ"
    sequence (:lastname) {|n| "Doe#{n}" }
    status "Active"
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