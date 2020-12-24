FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "入居者の年齢層が知りたいです！" }
    association :property
  end
end
