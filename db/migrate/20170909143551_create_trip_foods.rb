class CreateTripFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :trip_foods do |t|

      t.timestamps
    end
  end
end
