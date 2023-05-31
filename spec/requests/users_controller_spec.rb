require 'rails_helper'

RSpec.describe "UsersController", type: :controller do
  before do
    @controller = UsersController.new
    allow(controller).to receive(:current_user).and_return(user)
  end
  describe "GET /index, #show" do
    context 'when user is authenticated' do
      let(:user) { User.create(email: 'test@example.com', password: 'password', role: 'admin') }

      it 'returns a successful response' do
        user.update(role: 'admin')

        get :index
        expect(response).to have_http_status(200)
      end

      it "does not return a successful response" do
        user.update(role: 'operator')

        get :index
        expect(response).to have_http_status(401)
      end

      it 'assigns all users to @users' do

        get :index
        expect(response).to have_http_status(200)
        expect(assigns(:users)).to match_array([user])
      end

      it "renders show" do
        get :show, params: {id: user.id}

        expect(response).to have_http_status(200)
      end
    end
  end

  describe "POST users" do
    let(:valid_params) {{ email: 'test@example.com', password: 'password', password_confirmation: 'password' }}
    let(:user) {User.new(valid_params)}
    context "when user is created" do
      it "adds to the user database" do
        post :create, params: valid_params
        expect(response).to have_http_status(201)
      end

      it "does not add to the user database" do
        post :create, params: {email: 'test@example.com'}
        expect(response).to have_http_status(422)
      end
    end
  end
  

  describe 'PATCH users' do
    let(:user) { User.create(email: 'test@example.com', password: 'password', balance: 100) }
    context "when amount is updated" do
      let(:valid_params) {{id: user.id, amount: 50, firstname: 'elton'}}
      it "updates the user balance" do
        patch :topup_balance, params: valid_params
        user.reload
        expect(user.balance).to eq(150)
      end
      
      it "returns a successful response" do
        patch :topup_balance, params: valid_params
        expect(response).to have_http_status(200)
      end

      it "returns a successful reponse" do
        patch :update, params: valid_params
        expect(response).to have_http_status(200)
      end
    end

    context "when amount is less than 0" do
      let(:invalid_params) {{id: user.id, amount: -50}}
      it "renders an error" do
        patch :topup_balance, params: invalid_params
        expect(response).to have_http_status(422)
      end
    end
  end
end
