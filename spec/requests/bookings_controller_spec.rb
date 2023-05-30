require 'rails_helper'

RSpec.describe "BookingsController", type: :controller do
  before do
    @controller = BookingsController.new
  end
  describe "GET /index" do
    context 'when user is authenticated' do
      let(:user) { User.create(email: 'test@example.com', password: 'password') }

      before do
        allow(controller).to receive(:current_user).and_return(user)
      end
      it 'returns a successful response' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
