require 'rails_helper'

RSpec.describe Booking, type: :model do
  let(:user) { User.create(balance: 100) }
  let(:trip) { Trip.create(total_passengers: 3, total_amount: 100, capacity: 5, creator: user) }
  let(:booking) { Booking.new(user: user, trip: trip, start: Time.now, end: Time.now + 1.day, amount: 50, departure: 'Location A', status: 'pending') }

  describe "booking create" do
    context "when user balance is sufficient" do

      it "deducts user balance" do
        booking.deduct_user_balance_on_create_booking

        expect(user.balance).to eq(50)
      end
    end

    context "when trip capacity exceeds" do
      it "adds an error and returns false" do
        trip.total_passengers = trip.capacity
        booking.send(:check_trip_capacity_and_user_balance)
        expect(booking.errors[:error]).to include('Trip capacity exceeded')
        expect(booking.valid?).to be false
      end
    end

    context "when user balance is insufficient" do
      it "adds an error and returns false" do
        user.balance = 10
        booking.send(:check_trip_capacity_and_user_balance)
        expect(booking.errors[:error]).to include('Insufficient balance')
        expect(booking.valid?).to be false
      end
    end

    # context "when a user has a pending booking" do
    #   before do
    #     booking = Booking.create(user: user, trip: trip, start: Time.now, end: Time.now + 1.day, amount: 50, departure: 'Location B', status: 'pending')
    #   end
    #   it "adds an error" do

    #     booking.check_user_has_no_pending_bookings
    #     expect(booking.errors[:error]).to include('Commuter has an existing booking')
    #   end
    # end
  end

  describe "booking update" do
    # context "when a booking is cancelled" do
    #   before do
    #     booking.status = 'pending'
    #     booking.save
    #     booking.status = 'cancelled'
    #     booking.save

    #     booking.return_amount_if_cancelled_booking
    #   end
    #   it "refunds the amount back to the user" do
        
    #     expect(user.balance).to eq(150)
    #     expect(trip.total_passengers).to eq(2)
    #     expect(trip.total_amount).to eq(50)
    #   end
    # end

    # context "when a booking is completed" do
    #   before do
    #     booking.status = 'pending'
    #     puts booking.saved_change_to_status?
    #     booking.save
    #     puts booking.saved_change_to_status?
    #     booking.update(status: 'completed')
    #     puts booking.saved_change_to_status?
    #     booking.save
    #     puts booking.saved_change_to_status?
    #     puts booking.status
    #   end
    #   it "refunds the amount back to the user" do
    #     booking.update_operator_balance_if_completed_booking
        
    #     expect(trip.creator.balance).to eq(150)
    #   end
    # end

    context "when balance is sufficient" do
      it "deducts the amount from the user balance" do
        booking.deduct_user_balance_on_create_booking
  
        expect(user.balance).to eq(50)
      end
    end
  
    context "when trip has enough capacity" do
      it "adds to total passenger count and total amount count" do
        booking.update_trip_details_on_create_booking
  
        expect(trip.total_passengers).to eq(4)
        expect(trip.total_amount).to eq(150)
      end
    end
  end
end
