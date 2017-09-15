class CreateFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :foods do |t|
      t.integer :loafs_of_bread
      t.integer :pitas
      t.integer :bagels
      t.integer :tortillas
      t.float :lbs_of_pasta
      t.float :lbs_of_couscous
      t.float :lbs_of_chips
      t.float :lbs_of_sugar
      t.float :lbs_of_flour

      t.integer :onions
      t.integer :garlic_heads
      t.integer :peppers
      t.integer :tomatoes
      t.integer :carrots
      t.integer :potatoes
      t.integer :broccoli_heads
      t.integer :avocados
      t.string :other_vegetables

      t.integer :apples
      t.integer :oranges
      t.integer :bananas
      t.integer :peaches
      t.float :lbs_jelly
      t.integer :bags_of_crackers
      t.float :lbs_gorp
      t.string :other_fruits_or_snacks

      t.float :lbs_hummus
      t.float :lbs_veg_chili
      t.float :lbs_deh_beans
      t.float :lbs_peanut_butter
      t.float :lbs_turkey
      t.float :lbs_ham
      t.float :lbs_cheese
      t.float :lbs_falafel
      t.float :lbs_tuna
      t.string :other_proteins

      t.float :lbs_grits
      t.float :lbs_granola
      t.float :lbs_oatmeal
      t.float :lbs_grape_nuts
      t.float :lbs_cream_wheat
      t.float :lbs_hash_browns
      t.string :other_breakfast_items

      t.text :special_food_requests

      t.belongs_to :trip
      t.timestamps
    end
  end
end
