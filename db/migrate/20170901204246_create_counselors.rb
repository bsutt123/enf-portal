class CreateCounselors < ActiveRecord::Migration[5.1]
  def change
    create_table :counselors do |t|
      t.string :name
      t.string :email
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
