class CreateVans < ActiveRecord::Migration[5.1]
  def change
    create_table :vans do |t|
      t.integer :number
      t.integer :capacity

      t.timestamps
    end
  end
end
