require 'rails_helper'

RSpec.describe Trip, type: :model do
    let(:creator) { User.create(email: 'test@example.com') }
    let(:user) { User.create(email: 'user@example.com') }
    let(:trip) { Trip.new(user_id: user.id) }

    before do
        allow(trip).to receive(:creator).and_return(creator)
    end

    context "when creator has pending trips" do
        it "adds error to the trip" do
            trip.check_user_has_no_pending_trips
            expect(response).to have_http_status(200)
        end
    end
end
