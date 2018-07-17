FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Test Project #{n}" }
    description "Sample project for testing purposes"
    due_on 1.week.from_now
    association :owner # 和 owner 產生關聯

    trait :with_notes do
      after(:create) { |project| create_list(:note, 5, project: project) }
    end

    trait :due_yesterday do
      # Replace 'factory' with 'trait' -180717
      # factory :project_due_yesterday do
      # Omit repeated part of code:
      # factory :project_due_yesterday, class: Project do
      # sequence(:name) { |n| "Test Project #{n}" }
      # description "Sample project for testing purposes"
      due_on 1.day.ago
      # association :owner
    end

    trait :due_today do
      due_on Date.current.in_time_zone
    end

    trait :due_tomorrow do
      due_on 1.day.from_now
    end
  end
end
