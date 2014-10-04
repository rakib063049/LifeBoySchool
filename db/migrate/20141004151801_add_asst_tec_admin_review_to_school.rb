class AddAsstTecAdminReviewToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :assistant_teacher_name, :string
    add_column :schools, :contact_number, :string
    add_column :schools, :draft, :boolean, default: false
    add_column :schools, :back_checked, :boolean, default: false
    add_column :schools, :spot_checked, :boolean, default: false
    add_column :schools, :reviewed, :boolean, default: false
    add_column :schools, :comments, :text
  end
end
