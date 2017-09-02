class CreateEnfClasses < ActiveRecord::Migration[5.1]
  def change
    create_table :enf_classes do |t|
      t.string :name , null: false
      t.timestamps
    end
  end
end
