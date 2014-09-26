class AddFieldToThana < ActiveRecord::Migration
  def change
    add_column :thanas, :code, :string
  end
end
