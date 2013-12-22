class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.string :name
      t.string :ingredients
      t.text :notes
      t.text :instructions
      t.string :estimated_time

      t.timestamps
    end
  end
end
