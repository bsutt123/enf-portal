class CreateCounselors < ActiveRecord::Migration[5.1]
  def change
    create_table :counselors do |t|
      t.string :name

      t.boolean :lifegaurd, default: false
      t.boolean :wfa, default: false
      t.boolean :driver, default: false

      t.timestamps
    end
  end
end
