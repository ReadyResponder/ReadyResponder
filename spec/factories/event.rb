FactoryBot.define do
  factory :event do
    sequence(:title) { |n| "Training Event #{n}" }
    sequence(:id_code) { |n| "code_#{n}" }
    description "A good time was had by all"
    category "Training"
    status "Scheduled"
    min_title "Recruit"
    departments {[FactoryBot.create(:department)]}
    start_time Time.current
    end_time 23.hours.from_now

    trait :training do
      category "Training"
    end

    trait :meeting  do
      category "Meeting"
    end

    trait :patrol do
      category "Patrol"
    end

    trait :event do
      category "Event"
    end
  end
end
