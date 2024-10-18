class GetBitcoinPrice < BaseService
  COINDESK_API_URL = 'https://api.coindesk.com/v1/bpi/currentprice/USD.json'.freeze

  attr_reader :btc_usd_price

  def call
    get_btc_usd_price
    if @btc_usd_price
      success(@btc_usd_price)
    else
      failure(StandardError.new("Failed to get the Bitcoin price"))
    end
  end

  def get_btc_usd_price
    response = HTTP.get(COINDESK_API_URL)
    if response.status == 200
      @btc_usd_price = JSON.parse(response.body)['bpi']['USD']['rate']
    end
  end
end
