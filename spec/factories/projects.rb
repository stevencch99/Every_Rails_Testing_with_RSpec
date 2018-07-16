FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Test Project #{n}" }
    description "Sample project for testing purposes"
    due_on 1.week.from_now
    association :owner # 和 owner 產生關聯

    factory :project_due_yesterday do
      # Omit repeated part of code:
      # factory :project_due_yesterday, class: Project do
      # sequence(:name) { |n| "Test Project #{n}" }
      # description "Sample project for testing purposes"
      due_on 1.day.ago
      # association :owner
    end

    factory :project_due_today do
      due_on Date.current.in_time_zone
    end

    factory :project_due_tomorrow do
      due_on 1.day.from_now
    end
  end
end
