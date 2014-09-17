class CreateThanas < ActiveRecord::Migration
  def change
    create_table :thanas do |t|
      t.string :name
      t.integer :district_id

      t.timestamps
    end
  end
end
