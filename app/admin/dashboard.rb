ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Recent Schools" do
          table_for School.approved.order_as_district do

            column :year
            column :agency
            column :quarter
            column :unique_id
            column :state, label: 'Country'
            column :division
            column :district
            column :thana
            column :union
            column("School Name") { |school| link_to school.title, admin_school_path(school) }
            column :headmaster_name
            column :phone
            column :status
            column :boys
            column :girls
            column :total_students
            column :visits do |school|
              table_for school.visits.order('id ASC') do
                column :id do |visit|
                  link_to visit.id, [:admin, visit]
                end
                column :visited_at
              end
            end

          end
        end
      end
    end
  end
end
