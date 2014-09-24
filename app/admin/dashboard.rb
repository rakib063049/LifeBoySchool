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
          end
        end
      end

      column do
        panel "Recent Visits" do
          table_for Visit.all.order('id desc').limit(10) do
            column("Quarter") { |visit| link_to visit.quarter, admin_visit_path(visit) }
            column("School Name") { |visit| visit.school.title }
            column("Agency Name") { |visit| visit.agency.name }
            column("Visited At") { |visit| visit.visited_at }
          end
        end
      end
    end
  end
end
