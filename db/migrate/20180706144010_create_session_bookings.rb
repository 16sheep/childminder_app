class CreateSessionBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :session_bookings do |t|
      t.integer :user_id
      t.integer :session_id
      t.integer :child_id

      t.timestamps
    end
  end
end
