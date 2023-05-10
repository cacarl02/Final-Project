class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.string :start
      t.string :end
      t.datetime :departure
      t.decimal :total_amount
      t.integer :capacity
      t.integer :total_passengers
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
