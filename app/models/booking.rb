class Booking < ApplicationRecord
    belongs_to :user
    belongs_to :trip

    validates :trip_id, :user_id, :start, :end, :amount, :departure, :status, presence: true
    validate :check_trip_capacity_and_user_balance, on: :create
    validate :check_user_has_no_pending_bookings, on: :create

    after_create :deduct_user_balance_on_create_booking, :update_trip_details_on_create_booking
    after_update :return_amount_if_cancelled_booking, :update_operator_balance_if_completed_booking

    def self.create
        booking.save if booking.valid? && booking.check_trip_capacity_and_user_balance
    end

    def deduct_user_balance_on_create_booking
        user.update(balance: user.balance - amount)
    end
    
    def update_trip_details_on_create_booking
        if trip.total_passengers < trip.capacity
            trip.total_passengers += 1
            trip.total_amount += amount
            trip.save
        end
    end
    
    def return_amount_if_cancelled_booking
        if saved_change_to_status? && status_before_last_save == 'pending' && status == 'cancelled'
            user.update(balance: user.balance + amount)
        end
    end

    def update_operator_balance_if_completed_booking
        if saved_change_to_status? && status == 'completed'
            trip.creator.update(balance: trip.creator.balance + amount)
            trip.save
        end
    end

    private

    def check_trip_capacity_and_user_balance
        if trip.total_passengers >= trip.capacity
            errors.add(:error, 'Trip capacity exceeded')
            return false
        elsif user.balance < amount
            errors.add(:error, 'Insufficient balance')
            return false
        end
    end

    def check_user_has_no_pending_bookings
        if user.bookings.where(user_id: userid).where.not(status: ['completed', 'cancelled']).exists?
            errors.add(:error, 'Commuter has an existing booking')
        end
    end
end
