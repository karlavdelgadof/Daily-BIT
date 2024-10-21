# frozen_string_literal: true

class CreateTransaction < BaseService
  attr_reader :currency_sent, :currency_received, :amount_sent, :user

  def initialize(params)
    @currency_sent = params[:currency_sent]
    @currency_received = params[:currency_received]
    @amount_sent = params[:amount_sent].to_f
    @user = params[:user]
  end

  def call
    rate_result = GetBitcoinPrice.call
    return failure(result.error) unless rate_result.success?

    if @currency_sent.upcase == 'USD'
      create_buy_transaction(rate_result.payload)
    elsif @currency_sent.upcase == 'BTC'
      create_sell_transaction(rate_result.payload)
    else
      failure(ArgumentError.new("Invalid currency. Must be 'USD' or 'BTC'."))
    end
  end

  private

  def create_buy_transaction(rate)
    if @user.balance_usd < @amount_sent
      failure(StandardError.new('Insufficient balance'))
    else
      amount_received = (@amount_sent / rate).round(8)

      transaction = Transaction.create!(
        user: @user,
        current_transaction: 'buy',
        amount_sent: @amount_sent,
        currency_sent: @currency_sent,
        amount_received:,
        currency_received: @currency_received,
        exchange_rate: rate
      )
      success(transaction)
    end
  end

  def create_sell_transaction(rate)
    if @user.balance_btc < @amount_sent
      failure(StandardError.new('Insufficient balance'))
    else
      amount_received = (@amount_sent * rate).round(2)

      transaction = Transaction.create!(
        user: @user,
        current_transaction: 'sell',
        amount_sent: @amount_sent,
        currency_sent: @currency_sent,
        amount_received:,
        currency_received: @currency_received,
        exchange_rate: rate
      )
      success(transaction)
    end
  end
end
