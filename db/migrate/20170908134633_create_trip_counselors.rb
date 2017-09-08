class CreateTripCounselors < ActiveRecord::Migration[5.1]
  def change
    create_table :trip_counselors do |t|

      t.belongs_to :session_counselor
      t.belongs_to :trip

      t.timestamps
    end
  end
end
