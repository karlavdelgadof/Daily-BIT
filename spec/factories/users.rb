FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    balance_usd { 20000 }
    balance_btc { 20 }
  end
end
