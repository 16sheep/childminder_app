class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.belongs_to :parent, foreign_key: true
      t.belongs_to :child_minder, foreign_key: true

      t.timestamps
    end
  end
end
