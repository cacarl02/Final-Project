class Trip < ApplicationRecord
    has_many :bookings
    has_many :users, through: :bookings
    belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
    validates :start, :end, :departure, :capacity, presence: true

    validate :check_user_has_no_pending_trips, on: :create

    after_update :cancel_trip, :start_trip, :complete_trip

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
            bookings.where(status: 'pending').each do |booking|
                booking.status = 'ongoing'
                booking.save
            end
        end
    end

    def complete_trip
        if saved_change_to_status? && status == 'completed'
            bookings.where.not(status: 'cancelled').each do |booking|
                booking.status = 'completed'
                booking.save
            end
        end
    end

    private

    def check_user_has_no_pending_trips
        puts "spa"
        if creator.trips.where(user_id: user_id).where.not(status: ['completed', 'cancelled']).exists?
            errors.add(:error, 'Operator has an existing trip')
        end
    end
end
