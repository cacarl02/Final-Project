require 'rails_helper'

RSpec.describe "UsersController", type: :controller do
  before do
    @controller = UsersController.new
  end
  describe "GET /index, #show" do
    context 'when user is authenticated' do
      let(:user) { User.create(email: 'test@example.com', password: 'password', role: 'admin') }

      before do
        allow(controller).to receive(:current_user).and_return(user)
      end

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

  describe 'POST create' do
    context "with valid params" do
      let(:valid_params) {{email: 'test@example.com', password: 'password'}}
      it "creates a new user" do
      end
    end
  end

  describe 'PATCH users' do
    context "when amount is updated" do
      let(:user) { User.create(email: 'test@example.com', password: 'password', role: 'operator') }
      it "render user data" do
        patch :topup_balance, params: {id: user.id}

        expect(response).to have_http_status(200)
      end
    end
  end
end
