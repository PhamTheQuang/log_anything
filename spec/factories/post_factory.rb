FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    after(:build) do |post|
      post.user = create(:user) if post.user.nil?
    end
  end
end
