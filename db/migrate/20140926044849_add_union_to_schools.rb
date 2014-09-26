class AddUnionToSchools < ActiveRecord::Migration
  def change
    remove_column :schools, :union_id
    add_column :schools, :union, :string
  end
end
