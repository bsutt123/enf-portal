class CreateCounselors < ActiveRecord::Migration[5.1]
  def change
    create_table :counselors do |t|
      t.string :name
      t.timestamps
    end
  end
end
