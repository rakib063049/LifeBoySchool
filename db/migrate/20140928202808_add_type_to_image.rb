class AddTypeToImage < ActiveRecord::Migration
  def change
    add_column :images, :type, :string
    add_column :images, :school_id, :integer
  end
end
