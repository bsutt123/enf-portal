class CreateInstructors < ActiveRecord::Migration[5.1]
  def change
    create_table :instructors do |t|
      t.belongs_to :session_counselor, index: true
      t.belongs_to :enf_class, index: true

      t.integer :days_attend, default: 0
      t.timestamps
    end
  end
end
