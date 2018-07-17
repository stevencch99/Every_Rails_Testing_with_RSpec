FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name "Aaron"
    last_name "Sumner"
    # email "testtest@example.com"
    sequence(:email) { |n| "tester#{n}@example.com" }
    password "dottle-nouveau-pavilion-tights-furze"

	  trait :male_user do
	    first_name "Joe"
	    last_name "Tester"
	    email "joetester180709@example.com"
	    password "dottle-nouveau-pavilion-tights-furze"
	  end
  end
end
