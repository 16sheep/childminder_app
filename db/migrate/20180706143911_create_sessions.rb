class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.datetime :time_from
      t.datetime :time_until
      t.integer :user_id
      t.integer :number_of_children
      t.integer :cost_per_hour

      t.timestamps
    end
  end
end
