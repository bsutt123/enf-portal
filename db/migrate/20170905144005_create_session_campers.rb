class CreateSessionCampers < ActiveRecord::Migration[5.1]
  def change
    create_table :session_campers do |t|
      t.belongs_to :camper, index: true
      t.belongs_to :cabin, index: true
      t.belongs_to :session, index: true

      t.integer :table_number
      t.timestamps
    end
  end
end
