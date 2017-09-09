class CreateTripCampers < ActiveRecord::Migration[5.1]
  def change
    create_table :trip_campers do |t|

      t.belongs_to :trip, index: true
      t.belongs_to :session_camper, index: true


      t.timestamps
    end
  end
end
