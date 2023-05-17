class Trip < ApplicationRecord
    has_many :bookings
    has_many :users, through: :bookings

    after_update :cancel_trip

    def cancel_trip
        if saved_change_to_status? && status_before_last_save == 'pending' && status == 'cancelled'
            bookings.each do |booking|
                refund_amount = booking.amount
                booking.status = 'cancelled'
                booking.save

                user = booking.user
                user.balance += refund_amount
                user.save
            end
        end
    end

    def start_trip
        if saved_change_to_status? && status_before_last_save == 'pending' && status == 'ongoing'

        end
    end
end
