class CreateUnions < ActiveRecord::Migration
  def change
    create_table :unions do |t|
      t.string :name
      t.integer :thana_id

      t.timestamps
    end
  end
end
