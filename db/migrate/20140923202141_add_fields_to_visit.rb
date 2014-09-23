class AddFieldsToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :approve, :boolean, default: false
  end
end
