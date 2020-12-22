FactoryBot.define do
  factory :user, aliases: [:follower, :followed] do
    name { Faker::Name.name }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { "yeahlog" }
    password_confirmation { "yeahlog" }
    introduction { "下北沢に住んで3年になります！宜しくお願いします。" }
    sex { "男性" }

    trait :admin do
      admin { true }
    end
  end
end