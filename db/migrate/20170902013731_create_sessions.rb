class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.integer :number
      t.date :start
      t.date :finish
      t.string :identifier
      t.timestamps
    end
  end
end
