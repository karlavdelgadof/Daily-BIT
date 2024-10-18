RSpec.describe GetBitcoinPrice do
  let(:response) { GetBitcoinPrice.new.call }
  let(:btc_usd_price) { response.payload }
  let(:error) { response.error }
  let(:error_message) { error.message }


  describe 'when the API call is successful' do
    before do
      allow(HTTP).to receive(:get).and_return(double(success?: true, body: { 'bpi' => { 'USD' => { 'rate' => '10000' } } }.to_json))
    end


    it 'returns the Bitcoin price' do
      expect(btc_usd_price).to eq('10000')
    end
  end
end
