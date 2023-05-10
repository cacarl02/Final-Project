class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :role
      t.string :firstname
      t.string :lastname
      t.binary :photo_data
      t.decimal :balance

      t.timestamps
    end
  end
end
