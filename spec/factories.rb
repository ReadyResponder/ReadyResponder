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
    sequence (:icsid) {|n| "50#{n}" }
    status "Active"
    start_date Date.yesterday
    division1 'Command'
    division2 'Command'
    title 'Captain'
    gender 'Female'
    department 'Police'
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
    item
  end

  factory :event do
    title "A Training Event"
    category "Training"
    status "Scheduled"
    start_time Time.now
  end

  factory :timecard do
    person
    event
    category "Training"
    intended_start_time "2013-12-23 03:31"
    intended_end_time "2013-12-23 04:31"
    intention "Volunteered"
    #I don't want anything in a factory that isn't needed to make a valid object
    #actual_start_time "2012-12-23 03:31"
    #actual_end_time "2012-12-23 05:31"
    #outcome "Actual"
  end
end
