
FactoryBot.define do
  factory :tag do
    tag_name { Faker::Lorem.word }
    count { Faker::Number.number(digits: 2)}
  end
end
