RSpec.describe TransactionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'POST #create' do
    let(:transaction_params) do
      {
        currency_sent: 'USD',
        currency_received: 'BTC',
        amount_sent: 1000
      }
    end

    context 'with valid parameters' do
      before do
        allow(GetBitcoinPrice).to receive(:call).and_return(double(success?: true, payload: '2000'))
        allow(CreateTransaction).to receive(:call).with(transaction_params)
      end

      it 'creates a new transaction' do
        post :create, params: { user_id: user.id, transaction: transaction_params }
        expect(JSON.parse(response.body)).to include('transaction', 'user_balances')
      end
    end
  end


  describe 'GET #index' do
    before do
      create(:buy_transaction, user: user)
      create(:sell_transaction, user: user)
    end

    it 'returns a list of transactions for the user' do
      get :index, params: { user_id: user.id }
      expect(JSON.parse(response.body).size).to eq(user.transactions.size)
    end
  end


  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:transaction) { create(:sell_transaction, user: user) }

    it 'returns a specific transaction for the user' do
      get :show, params: { user_id: user.id, id: transaction.id }
      expect(JSON.parse(response.body)).to include('id', 'current_transaction', 'amount_sent', 'currency_sent', 'currency_received', 'amount_received', 'exchange_rate')
    end
  end
end
