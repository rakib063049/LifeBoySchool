class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :visit_id

      t.timestamps
    end
  end
end
