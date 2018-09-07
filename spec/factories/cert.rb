FactoryBot.define do
  factory :cert do
    status "Active"
    issued_date Date.today
    person
    course
  end
end
