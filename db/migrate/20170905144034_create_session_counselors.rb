class CreateSessionCounselors < ActiveRecord::Migration[5.1]
  def change
    create_table :session_counselors do |t|
      t.belongs_to :session, index: true
      t.belongs_to :cabin, index: true
      t.belongs_to :counselor, index: true

      t.timestamps
    end
  end
end
