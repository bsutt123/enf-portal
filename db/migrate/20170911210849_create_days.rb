class CreateDays < ActiveRecord::Migration[5.1]
  def change
    create_table :days do |t|

      t.date :date, null: false

      t.belongs_to :session

      t.timestamps
    end
  end
end
