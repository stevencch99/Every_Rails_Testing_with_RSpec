FactoryBot.define do
  factory :note do
    message "My important note."
    association :project
    # association :user
    user { project.owner } # 指定為同一位用戶
  end
end
