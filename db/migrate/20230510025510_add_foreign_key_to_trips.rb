class AddForeignKeyToTrips < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :trips, :users
  end
end
