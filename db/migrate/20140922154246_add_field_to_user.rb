class AddFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    add_column :users, :roles_mask, :integer
  end
end
