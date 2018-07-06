class CreatePostings < ActiveRecord::Migration[5.2]
  def change
    create_table :postings do |t|
      t.integer :school_id
      t.integer :user_id

      t.timestamps
    end
  end
end
