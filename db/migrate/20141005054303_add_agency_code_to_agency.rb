class AddAgencyCodeToAgency < ActiveRecord::Migration
  def change
    add_column :agencies, :code, :string
  end
end
