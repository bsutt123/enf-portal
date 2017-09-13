class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :description
      t.text :destination

      t.boolean :requires_food, default: false
      t.boolean :requires_gear, default: false
      t.boolean :requires_van, default: false
      t.boolean :requires_lifeguard, default: false
      t.boolean :requires_wfa, default: false
      t.boolean :day_trip

      t.belongs_to :session_counselor, index: true
      t.belongs_to :session, index: true

      t.integer :start_day_id
      t.integer :end_day_id

      t.string :start_period
      t.string :end_period

      t.references :trip_group, polymorphic: true, index: true
      t.timestamps
    end
  end
end
