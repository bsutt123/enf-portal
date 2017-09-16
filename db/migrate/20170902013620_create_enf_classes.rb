class CreateEnfClasses < ActiveRecord::Migration[5.1]
  def change
    create_table :enf_classes do |t|
      t.string :name , null: false
      t.belongs_to :session, index: true

      t.integer :period
      t.timestamps
    end
  end
end
