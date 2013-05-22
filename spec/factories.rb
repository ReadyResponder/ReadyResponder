FactoryGirl.define do
  factory :user do
    sequence (:username) {|n| "test#{n}" }
    sequence (:email) {|n| "test#{n}@example.com" }
    confirmed_at Time.now
    password 'secret'
    password_confirmation 'secret'
    firstname "CJ"
    lastname "Doe"
  end
  
  factory :role do
    sequence (:name) {|n| "testrole#{n}" }
  end

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
  factory :inspection do
    status "Passed"
    person
  end

  factory :event do
    instructor "MyString"
    location "MyString"
    description "MyString"
    start_date "2012-12-14 05:50:18"
    end_date "2012-12-14 05:50:18"
    duration 1
    category "Training"
    status "Completed"
  end
  
  factory :attendance do
    category "Training"
    est_start_time "2012-12-23 03:31:31"
    start_time "2012-12-23 03:31:31"
    est_end_time "2012-12-23 03:31:31"
    end_time "2012-12-23 04:31"
    duration "9.99"
    person
    event
  end

end