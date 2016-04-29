class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.integer :year, null: false
      t.integer :rating, null: false
      t.string  :category, null: false
      t.string  :cast, null: false
      t.string  :director, null: false
      t.string  :summary, null: false
      t.string  :poster

      t.timestamps null: false
    end
  end
end
