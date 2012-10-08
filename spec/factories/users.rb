# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence (:username) {|n| "test#{n}" }
    sequence (:email) {|n| "test#{n}@example.com" }
    confirmed_at Time.now
    password 'secret'
    password_confirmation 'secret'
  end
end
