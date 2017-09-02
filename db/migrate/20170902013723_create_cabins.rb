class CreateCabins < ActiveRecord::Migration[5.1]
  def change
    create_table :cabins do |t|
      t.integer :number
      t.timestamps
    end
  end
end
