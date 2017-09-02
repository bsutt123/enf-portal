class CreateCampers < ActiveRecord::Migration[5.1]
  def change
    create_table :campers do |t|
      t.belongs_to :cabin, index: true
      t.belongs_to :session, index: true
      t.timestamps
    end
  end
end
