ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Recently Approved Schools" do
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

            column "Visit#1" do |school|
              table_for school.first_visit do
                column :visited_at
                column :certificate do
                  school.first_visit.acknowledgement_certificates.map { |img| link_to "Image", img.photo.url, target: '_blank' }.join(', ').html_safe rescue nil
                end
                column :images do
                  school.first_visit.images.map { |img| link_to "Image", img.photo.url, target: '_blank' }.join(', ').html_safe rescue nil
                end

              end
            end

            column "Visit#2" do |school|
              table_for school.second_visit do
                column :visited_at
                column :certificate do
                  school.second_visit.acknowledgement_certificates.map { |img| link_to "Image", img.photo.url, target: '_blank' }.join(', ').html_safe rescue nil
                end
                column :images do
                  school.second_visit.images.map { |img| link_to "Image", img.photo.url, target: '_blank' }.join(', ').html_safe rescue nil
                end
              end
            end

            column "Visit#3" do |school|
              table_for school.third_visit do
                column :visited_at
                column :certificate do
                  school.third_visit.acknowledgement_certificates.map { |img| link_to "Image", img.photo.url, target: '_blank' }.join(', ').html_safe rescue nil
                end
                column :images do
                  school.third_visit.images.map { |img| link_to "Image", img.photo.url, target: '_blank' }.join(', ').html_safe rescue nil
                end

              end
            end

            column "Visit#4" do |school|
              table_for school.fourth_visit do
                column :visited_at
                column :certificate do
                  school.fourth_visit.acknowledgement_certificates.map { |img| link_to "Image", img.photo.url, target: '_blank' }.join(', ').html_safe rescue nil
                end
                column :images do
                  school.fourth_visit.images.map { |img| link_to "Image", img.photo.url, target: '_blank' }.join(', ').html_safe rescue nil
                end

              end
            end
          end
        end
      end
    end
  end
end
