class CreateFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :foods do |t|
      t.integer :apples
      t.integer :oranges
      t.integer :bananas
      t.integer :avocados
      t.integer :bags_of_chips
      t.integer :pitas
      t.integer :bread_slices


      t.float :lbs_turkey
      t.float :lbs_ham
      t.float :lbs_peanut_butter
      t.float :lbs_jelly

      t.belongs_to :trip
      t.timestamps
    end
  end
end
