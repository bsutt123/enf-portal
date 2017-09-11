class CreateTripGears < ActiveRecord::Migration[5.1]
  def change
    create_table :trip_gears do |t|

      t.timestamps
    end
  end
end
