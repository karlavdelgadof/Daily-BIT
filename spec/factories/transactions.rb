# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    factory :buy_transaction do
      current_transaction { 'buy' }
      amount_sent { 100.00 }
      currency_sent { 'USD' }
      currency_received { 'BTC' }
      amount_received { 0.00001 }
      exchange_rate { 20_000 }
      user
    end

    factory :sell_transaction do
      current_transaction { 'sell' }
      amount_sent { 1.00 }
      currency_sent { 'BTC' }
      currency_received { 'USD' }
      amount_received { 20_000 }
      exchange_rate { 20_000 }
      user
    end
  end
end
