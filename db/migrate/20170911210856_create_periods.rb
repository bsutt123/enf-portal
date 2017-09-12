class CreatePeriods < ActiveRecord::Migration[5.1]
  def change
    create_table :periods do |t|
      t.integer :order
      t.integer :name

      t.belongs_to :day
      t.timestamps
    end
  end
end
