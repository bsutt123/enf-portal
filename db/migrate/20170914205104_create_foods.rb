class CreateFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :foods do |t|
      t.integer :loafs_of_bread, default: 0
      t.integer :pitas, default: 0
      t.integer :bagels, default: 0
      t.integer :tortillas, default: 0
      t.float :lbs_of_pasta, default: 0
      t.float :lbs_of_couscous, default: 0
      t.float :lbs_of_chips, default: 0
      t.float :lbs_of_sugar, default: 0
      t.float :lbs_of_flour, default: 0

      t.integer :onions, default: 0
      t.integer :garlic_heads, default: 0
      t.integer :peppers, default: 0
      t.integer :tomatoes, default: 0
      t.integer :carrots, default: 0
      t.integer :potatoes, default: 0
      t.integer :broccoli_heads, default: 0
      t.integer :avocados, default: 0
      t.text :other_vegetables

      t.integer :apples, default: 0
      t.integer :oranges, default: 0
      t.integer :bananas, default: 0
      t.integer :peaches, default: 0
      t.float :lbs_jelly, default: 0
      t.integer :bags_of_crackers, default: 0
      t.float :lbs_gorp, default: 0
      t.text :other_fruits_or_snacks

      t.float :lbs_hummus, default: 0
      t.float :lbs_veg_chili, default: 0
      t.float :lbs_deh_beans, default: 0
      t.float :lbs_peanut_butter, default: 0
      t.float :lbs_turkey, default: 0
      t.float :lbs_ham, default: 0
      t.float :lbs_cheese, default: 0
      t.float :lbs_falafel, default: 0
      t.float :lbs_tuna, default: 0
      t.text :other_proteins

      t.float :lbs_grits, default: 0
      t.float :lbs_granola, default: 0
      t.float :lbs_oatmeal, default: 0
      t.float :lbs_grape_nuts, default: 0
      t.float :lbs_cream_wheat, default: 0
      t.float :lbs_hash_browns, default: 0
      t.text :other_breakfast_items

      t.text :special_food_requests

      t.belongs_to :trip
      t.timestamps
    end
  end
end
