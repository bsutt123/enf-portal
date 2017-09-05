class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.belongs_to :session_camper, index: true
      t.belongs_to :enf_class, index: true
      t.timestamps
    end
  end
end
