class AddExtraFieldToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :agency_id, :integer
    add_column :schools, :quarter, :string
  end
end
