# frozen_string_literal: true

class User < ApplicationRecord
  has_many :transactions

  before_update :update_balance_usd, :update_balance_btc

  def update_balance_usd
    return unless balance_usd_changed?

    balance_usd_was.to_f + balance_usd.to_f
  end

  def update_balance_btc
    return unless balance_btc_changed?

    balance_btc_was.to_f + balance_btc.to_f
  end
end
