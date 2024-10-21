# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :user

  after_create :update_user_balance

  private

  def update_user_balance
    if current_transaction == 'buy'
      user.update(balance_usd: user.balance_usd - amount_sent)
      user.update(balance_btc: user.balance_btc + amount_received)
    else
      user.update(balance_usd: user.balance_usd + amount_received)
      user.update(balance_btc: user.balance_btc - amount_sent)
    end
  end
end
