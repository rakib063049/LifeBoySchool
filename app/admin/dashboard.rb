ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Approved Schools" do
          table_for School.approved.order_as_district do
            column :year
            column :quarter
            column("Unique ID No of Schools") { |school| school.unique_id }
            column("Implementing Agency") { |school| school.agency.try(:name) }
            column("Country") { |school| school.state }
            column :division
            column :district
            column :thana
            column :union
            column("Name Of School") { |school| link_to school.title, admin_school_path(school) }
            column("Name Of the School Authority") { |school| school.headmaster }
            column :phone
            column :mobile
            column :status
            column("Male") { |school| school.boys }
            column("Female") { |school| school.girls }
            column("Total") { |school| school.total_students }
            column("Data Entry Operator") { |school| school.data_entry_operator }
            column("Data Entry Date") { |school| school.created_at }
          end
        end
      end
    end
  end
end
