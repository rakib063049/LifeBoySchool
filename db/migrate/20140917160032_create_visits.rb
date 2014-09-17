class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :quarter
      t.datetime :visited_at
      t.integer :school_id
      t.integer :agency_id
      t.integer :created_by

      t.timestamps
    end
  end
end
