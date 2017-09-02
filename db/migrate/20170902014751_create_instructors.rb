class CreateInstructors < ActiveRecord::Migration[5.1]
  def change
    create_table :instructors do |t|
      t.belongs_to :counselor, index: true
      t.belongs_to :enf_class, index: true


      t.timestamps
    end
  end
end