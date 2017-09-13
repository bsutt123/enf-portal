class CreateSessionVans < ActiveRecord::Migration[5.1]
  def change
    create_table :session_vans do |t|
      t.belongs_to :session, index: true
      t.belongs_to :van, index: true
      t.timestamps
    end
  end
end
