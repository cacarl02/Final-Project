class Booking < ApplicationRecord
    belongs_to :user
    belongs_to :trip

    after_create :deduct_user_balance_on_create, :update_trip_details_on_create
    after_update :return_amount_if_cancelled

    def deduct_user_balance_on_create
        user.update(balance: user.balance - amount)
    end

    def return_amount_if_cancelled
        if saved_change_to_status? && status_before_last_save == 'pending' && status == 'cancelled'
            user.update(balance: user.balance + amount)
        end
    end

    def update_trip_details_on_create
        trip.total_passengers += 1
        trip.total_amount += amount
        trip.save
    end
end
