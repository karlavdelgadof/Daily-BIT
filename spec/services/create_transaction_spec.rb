RSpec.describe CreateTransaction do
  let(:user) { create(:user, balance_usd: 1000, balance_btc: 10) }
  let(:transaction_params) do
    {
      currency_sent: 'USD',
      currency_received: 'BTC',
      amount_sent: 1000,
      user: user
    }
  end

  describe '#call' do
    context 'when the API call is successful' do
      before do
        allow(GetBitcoinPrice).to receive(:call).and_return(double(success?: true, payload: '2000'))
      end


      it 'creates a new transaction' do
        result = CreateTransaction.new(transaction_params).call
        expect(result.success?).to be true
      end
    end
  end
end
