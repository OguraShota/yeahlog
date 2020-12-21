User.create!(name:  "竈門 炭治郎",
            email:  "sample@example.com",
            password:               "yeahlog",
            password_confirmation:  "yeahlog",
            admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "sample-#{n+1}@example.com"
  password = "password"
  User.create!(name:  name,
              email:  email,
              password:               password,
              password_confirmation:  password)
  end

  10.times do |n|
    Property.create!(name: "Shimokitaマンション",
                 description: "下北沢駅南口より徒歩5分の物件です！",
                 reference: "https://suumo.jp/library/tf_13/sc_13112/to_1000617572/",
                 recommend: 5,
                 user_id: 1)
  end