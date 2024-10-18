class TransactionsController < ApplicationController
  before_action :set_user
  def create
    result = CreateTransaction.new(transaction_params).call
    if result.success?
      render json: { transaction: result.payload, user_balances: user_attributes }, status: :created
    else
      render json: { error: result.error.message }, status: :internal_server_error
    end
  end

  def index
    transactions = @user.transactions
    render json: transactions
  end

  def show
    transaction = @user.transactions.find(params[:id])
    render json: transaction
  end

  private

  def transaction_params
    params.require(:transaction).permit(:currency_sent, :currency_received, :amount_sent).merge(user: @user)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def user_attributes
    { balance_usd: @user.balance_usd, balance_btc: @user.balance_btc }
  end
end
