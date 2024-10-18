RSpec.describe BitcoinPriceController, type: :controller do
  describe 'GET #show' do
    context 'when the API call is successful' do
      before do
        allow(GetBitcoinPrice).to receive(:call).and_return(
          instance_double('BaseService::Response', success?: true, payload: 50000.0)
        )
        get :show
      end

      it 'returns the Bitcoin price' do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq('btc_usd_price' => 50000.0)
      end
    end

    context 'when the API call fails' do
      before do
        allow(GetBitcoinPrice).to receive(:call).and_return(
          instance_double('BaseService::Response', success?: false, error: StandardError.new('Failed to get the Bitcoin price'))
        )
        get :show
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)).to eq('error' => 'Failed to get the Bitcoin price')
      end
    end
  end
end
