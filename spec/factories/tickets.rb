
FactoryBot.define do
  factory :ticket do
    user_id { Faker::Number.number(digits: 2) }
    title   { Faker::Lorem.sentence }
  end
end
  