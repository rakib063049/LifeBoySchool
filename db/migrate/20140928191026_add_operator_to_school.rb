class AddOperatorToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :honorific, :string
    add_column :schools, :mobile, :string
    add_column :schools, :data_entry_operator, :string
  end
end
