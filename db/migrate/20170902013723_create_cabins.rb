class CreateCabins < ActiveRecord::Migration[5.1]
  def change
    create_table :cabins do |t|
      t.integer :number, default: 0
      t.belongs_to :session, index: true
      t.timestamps
    end
  end
end
