class CreateCampers < ActiveRecord::Migration[5.1]
  def change
    create_table :campers do |t|
      t.string :name
      
      t.boolean :non_swimmer
      t.boolean :has_food_allergies
      t.boolean :has_medication



      t.timestamps
    end
  end
end
