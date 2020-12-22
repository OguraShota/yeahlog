FactoryBot.define do
  factory :property do
    name { "下北沢マンション" }
    description { "下北沢南口より徒歩5分、全部屋南向きの物件です" }
    reference { "https://suumo.jp/library/tf_13/sc_13112/to_1000617572/" }
    recommend { 5 }
    association :user
    created_at { Time.current }
  end

  trait :yesterday do
    created_at { 1.day.ago }
  end

  trait :one_week_ago do
    created_at { 1.week.ago }
  end

  trait :one_month_ago do
    created_at { 1.month.ago }
  end

  trait :picture do
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/property1.jpg')) }
  end
end
