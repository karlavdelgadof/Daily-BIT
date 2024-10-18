class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save!
      render json: { user: user }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :bad_request
    end
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = User.find(params[:id])
    if user.update!(user_params)
      render json: user
    else
      render json: { error: user.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { message: 'User deleted' }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :balance_usd, :balance_btc)
  end
end
