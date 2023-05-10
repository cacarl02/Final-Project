class AddForeignKeyToBookings < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :bookings, :users
    add_foreign_key :bookings, :trips
  end
end
