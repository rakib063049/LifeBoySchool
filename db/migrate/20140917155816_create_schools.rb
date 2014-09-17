class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :year
      t.string :unique_id
      t.string :state
      t.integer :division_id
      t.integer :district_id
      t.integer :thana_id
      t.integer :union_id
      t.string :title
      t.string :headmaster_name
      t.string :phone
      t.integer :boys
      t.integer :girls
      t.integer :created_by

      t.timestamps
    end
  end
end
