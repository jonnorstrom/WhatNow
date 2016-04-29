class CreateZipcodes < ActiveRecord::Migration
  def change
    create_table :zipcodes do |t|
      t.string :zip, null: false
      t.integer :lat, null: false
      t.integer :lng, null: false

      t.timestamps null: false
    end
  end
end
