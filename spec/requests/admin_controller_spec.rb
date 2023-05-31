# require 'rails_helper'

# RSpec.describe "AdminController", type: :controller do
#   before do
#     @controller = AdminController.new
#     allow(controller).to receive(:set_user)
#     allow(controller).to receive(:authorize_admin)
#   end
#   let(:admin_user) { User.create(email: 'admin@admin.com', role: 'admin') }
#   let(:user) { User.create(email: 'user@example.com', role: 'user') }

#   describe 'GET show' do
#     context 'when admin user is authenticated' do
#       before do
#         allow(controller).to receive(:current_user).and_return(admin_user)
#       end

#       it 'renders the user JSON' do
#         get :show, params: { id: user.id }
#         expect(response).to have_http_status(200)
#         expect(response.body).to eq(user.to_json)
#       end
#     end

#     context 'when non-admin user is authenticated' do
#       before do
#         allow(controller).to receive(:current_user).and_return(user)
#       end

#       it 'returns unauthorized error' do
#         get :show, params: { id: user.id }
#         expect(response).to have_http_status(401)
#         expect(response.body).to eq({ error: 'Access denied. Admin privileges required.' }.to_json)
#       end
#     end

#     context 'when no user is authenticated' do
#       before do
#         allow(controller).to receive(:current_user).and_return(nil)
#       end

#       it 'returns unauthorized error' do
#         get :show, params: { id: user.id }
#         expect(response).to have_http_status(401)
#         expect(response.body).to eq({ error: 'Access denied. Admin privileges required.' }.to_json)
#       end
#     end
#   end

#   describe 'PATCH verify_user' do
#     context 'when admin user is authenticated' do
#       before do
#         allow(controller).to receive(:current_user).and_return(admin_user)
#       end

#       it 'updates the user verification status' do
#         expect(user.is_verified).to be_falsey

#         patch :verify_user, params: { id: user.id }

#         expect(response).to have_http_status(200)
#         expect(user.reload.is_verified).to be_truthy
#       end

#       it 'renders the verification message JSON' do
#         patch :verify_user, params: { id: user.id }

#         expect(response).to have_http_status(200)
#         expect(response.body).to eq({ message: "User #{user.email} has been verified." }.to_json)
#       end
#     end

#     context 'when non-admin user is authenticated' do
#       before do
#         allow(controller).to receive(:current_user).and_return(user)
#       end

#       it 'returns unauthorized error' do
#         patch :verify_user, params: { id: user.id }
#         expect(response).to have_http_status(401)
#         expect(response.body).to eq({ error: 'Access denied. Admin privileges required.' }.to_json)
#       end
#     end

#     context 'when no user is authenticated' do
#       before do
#         allow(controller).to receive(:current_user).and_return(nil)
#       end

#       it 'returns unauthorized error' do
#         patch :verify_user, params: { id: user.id }
#         expect(response).to have_http_status(401)
#       end
#     end
#   end
# end