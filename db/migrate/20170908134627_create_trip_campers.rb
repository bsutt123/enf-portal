class CreateTripCampers < ActiveRecord::Migration[5.1]
  def change
    create_table :trip_campers do |t|
      
      t.belongs_to :session_campers
      t.belongs_to :session_counselor


      t.timestamps
    end
  end
end
