class CreateTransaction < BaseService
  attr_reader :currency_sent, :currency_received, :amount_sent, :user
  def initialize(params)
    @currency_sent = params[:currency_sent]
    @currency_received = params[:currency_received]
    @amount_sent = transform_value(params[:amount_sent])
    @user = params[:user]
  end

  def call
    rate_result = GetBitcoinPrice.call
    return failure(result.error) unless rate_result.success?

    rate = transform_value(rate_result.payload)
    if @currency_sent.upcase == 'USD'
      create_buy_transaction(rate)
    elsif @currency_sent.upcase == 'BTC'
      create_sell_transaction(rate)
    else
      failure(ArgumentError.new("Invalid currency. Must be 'USD' or 'BTC'."))
    end
  end

  private

  def create_buy_transaction(rate)
    if @user.balance_usd < @amount_sent
      failure(StandardError.new("Insufficient balance"))
    else

      amount_received = transform_value(@amount_sent / rate, 8)

      transaction = Transaction.create!(
        user: @user,
        current_transaction: 'buy',
        amount_sent: @amount_sent,
        currency_sent: @currency_sent,
        amount_received: amount_received,
        currency_received: @currency_received,
        exchange_rate: rate
      )
      success(transaction)
    end
  end


  def create_sell_transaction(rate)
    if @user.balance_btc < @amount_sent
      failure(StandardError.new("Insufficient balance"))
    else
      amount_received = transform_value(@amount_sent * rate, 2)

      transaction = Transaction.create!(
        user: @user,
        current_transaction: 'sell',
        amount_sent: @amount_sent,
        currency_sent: @currency_sent,
        amount_received: amount_received,
        currency_received: @currency_received,
        exchange_rate: rate
      )
      success(transaction)
    end
  end

  def transform_value(value, n = 0)
    val = value.to_s.gsub(',', '')
    BigDecimal(val).to_d.round(n)
  end
end
