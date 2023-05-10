class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.string :start
      t.string :end
      t.datetime :departure
      t.decimal :amount
      t.string :status
      t.integer :trip_id
      t.integer :user_id

      t.timestamps
    end
  end
end
