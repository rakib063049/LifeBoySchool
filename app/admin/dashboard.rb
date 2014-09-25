ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Recent Schools" do
          table_for School.all.order('id desc').limit(10) do
            column("Title") { |school| link_to school.title, admin_school_path(school) }
            column("Uniq Id") { |school| school.unique_id }
            column("HeadMaster Name") { |school| school.headmaster_name }
            column("Phone") { |school| school.phone }
            column("Phone") { |school| school.status }

            column :visits do |school|
              table_for school.visits.order('id ASC') do
                column :id do |visit|
                  link_to visit.id, [:admin, visit]
                end
                column :quarter
                column :agency_id do |visit|
                  visit.agency.name
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
