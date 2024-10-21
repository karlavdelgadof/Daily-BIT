# frozen_string_literal: true

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    let(:user_params) do
      {
        name: 'John Doe',
        email: Faker::Internet.email
      }
    end

    context 'with valid parameters' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: user_params }
        end.to change(User, :count).by(1)

        expect(JSON.parse(response.body)).to include('user')
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }

    it 'returns the user' do
      get :show, params: { id: user.id }
      expect(JSON.parse(response.body)).to match(JSON.parse(user.to_json))
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }
    let(:updated_user_params) do
      {
        name: 'Jane Doe'
      }
    end

    it 'updates the user' do
      put :update, params: { id: user.id, user: updated_user_params }
      user.reload
      expect(user.name).to eq('Jane Doe')
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }

    it 'deletes the user' do
      expect do
        delete :destroy, params: { id: user.id }
      end.to change(User, :count).by(-1)
    end
  end
end
