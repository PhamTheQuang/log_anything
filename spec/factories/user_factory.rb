FactoryGirl.define do
  factory :user do
    sequence(:email) do |n|
      "user#{n}.email@example.com"
    end
    password "password123"
  end
end
