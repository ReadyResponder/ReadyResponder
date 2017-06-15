FactoryGirl.define do
  factory :event do
    sequence (:title) { |n| "Training Event #{n}" }
    sequence (:id_code) { |n| "code_#{n}" }
    description "A good time was had by all"
    category "Training"
    status "Scheduled"
    start_time Time.current
    end_time 23.hours.from_now
  end
end
