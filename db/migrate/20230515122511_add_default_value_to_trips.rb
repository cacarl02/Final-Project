class AddDefaultValueToTrips < ActiveRecord::Migration[7.0]
  def change
    change_column :trips, :total_passengers, :integer, default: 0
    change_column :trips, :total_amount, :decimal, default: 0
  end
end
