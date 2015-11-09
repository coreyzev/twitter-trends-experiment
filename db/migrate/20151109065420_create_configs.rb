class CreateConfigs < ActiveRecord::Migration
  def change
    create_table :configs do |t|
      t.text :address
      t.references :location, index: true, foreign_key: true
      t.integer :limit

      t.timestamps null: false
    end
  end
end
