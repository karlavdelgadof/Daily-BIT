# frozen_string_literal: true

class BitcoinPriceController < ApplicationController
  def show
    result = GetBitcoinPrice.call
    if result.success?
      render json: { btc_usd_price: result.payload }
    else
      render json: { error: result.error.message }, status: :internal_server_error
    end
  end
end
