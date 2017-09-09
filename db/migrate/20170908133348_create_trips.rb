class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :description
      t.string :destination

      t.boolean :requires_food
      t.boolean :requires_gear

      t.belongs_to :session_counselor, index: true
      t.belongs_to :session, index: true


      t.references :trip_group, polymorphic: true, index: true
      t.timestamps
    end
  end
end
