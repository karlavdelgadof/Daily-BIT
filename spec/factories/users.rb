# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    balance_usd { 20_000 }
    balance_btc { 20 }
  end
end
