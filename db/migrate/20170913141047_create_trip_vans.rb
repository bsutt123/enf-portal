class CreateTripVans < ActiveRecord::Migration[5.1]
  def change
    create_table :trip_vans do |t|
      t.belongs_to :trip, index: true
      t.belongs_to :session_van, index: true
      t.timestamps
    end
  end
end
