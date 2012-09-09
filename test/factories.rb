FactoryGirl.define do
  factory :person do
    firstname "CJ"
    sequence (:lastname) {|n| "Doe#{n}" }
    status "Active"
  end
  factory :cert do
    status "Active"
    issued_date 2012-8-3
    person
    course
  end
  factory :title do
    status "Active"
    sequence (:title) {|n|  "Skill#{n}" }
  end
  factory :skill do
    status "Active"
    sequence (:title) {|n|  "Skill#{n}" }
  end
  factory :course do
    status "Active"
    sequence (:title) {|n| "Course#{n}" }
  end

end