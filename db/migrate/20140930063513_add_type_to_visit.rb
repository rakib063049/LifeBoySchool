class AddTypeToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :type, :string
  end
end
