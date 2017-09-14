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
      t.boolean :day_trip, default: false
      t.boolean :approved, default: false



      t.belongs_to :session_counselor, index: true
      t.belongs_to :session, index: true

      t.integer :start_day_id
      t.date :start_date

      t.integer :end_day_id
      t.date :end_date

      t.string :start_period
      t.integer :start_period_num

      t.string :end_period
      t.integer :end_period_num
      
      t.references :trip_group, polymorphic: true, index: true
      t.timestamps
    end
  end
end
