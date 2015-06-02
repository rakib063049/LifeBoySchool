ActiveAdmin.register School, :as => 'AllSchool' do
  menu :if => proc { current_user.admin? }
  config.batch_actions = false
  config.clear_action_items!

  filter :year
  filter :created_at, label: 'Data Entry Date'
  filter :division
  filter :district
  filter :title

  index :download_links => proc { current_user.admin? } do
    column("Implementing Agency", sortable: 'schools.agency_id') { |school| school.agency.try(:name) }
    column :year
    column :quarter
    column("Unique ID No of Schools") { |school| school.unique_id }
    column("Country") { |school| school.state }
    column :division
    column :district
    column :thana
    column :union
    column("Name Of School") { |school| link_to school.title, admin_school_path(school) }
    column :completion_certificates do |school|
      school.completion_certificates.map { |img| link_to "Image", img.photo.url, target: '_blank' }.join(', ').html_safe rescue nil
    end
    column("Name Of the School Authority") { |school| school.headmaster }
    column :phone
    column :mobile
    column :status
    column("Male") { |school| school.boys }
    column("Female") { |school| school.girls }
    column("Total") { |school| school.total_students }

    column "Visit#1" do |school|
      table_for school.first_visit do
        column :visited_at do
          formated_date(school.first_visit.visited_at)
        end
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
        column :visited_at do
          formated_date(school.second_visit.visited_at)
        end
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
        column :visited_at do
          formated_date(school.third_visit.visited_at)
        end
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
        column :visited_at do
          formated_date(school.fourth_visit.visited_at)
        end
        column :certificate do
          school.fourth_visit.acknowledgement_certificates.map { |img| link_to "Image", img.photo.url, target: '_blank' }.join(', ').html_safe rescue nil
        end
        column :images do
          school.fourth_visit.images.map { |img| link_to "Image", img.photo.url, target: '_blank' }.join(', ').html_safe rescue nil
        end

      end
    end

    column :draft
    column :reviewed
    column :back_checked
    column :spot_checked
    column :comments


    column("Data Entry Operator") { |school| school.agency_operator }
    column("Data Entry Date") { |school| formated_datetime(school.created_at) }
  end

  csv do
    column :year
    column("Agency") { |school| school.agency.try(:name) }
    column :quarter
    column("Unique ID") { |school| school.unique_id }
    column("Country") { |school| school.state }
    column(:division) { |school| school.division.name }
    column(:district) { |school| school.district.name }
    column(:thana) { |school| school.thana.name }
    column :union
    column("Title") { |school| school.title }
    column("Headmaster") { |school| school.headmaster }
    column :phone
    column :mobile
    column :assistant_teacher_name
    column :contact_number
    column :status
    column :boys
    column :girls
    column("Total Student") { |school| school.total_students }
    column("Data Entry Operator") { |school| school.data_entry_operator }
    column("Visit#1") { |school| school.first_visit.try(:visited_at) }
    column("Visit#2") { |school| school.second_visit.try(:visited_at) }
    column("Visit#3") { |school| school.third_visit.try(:visited_at) }
    column("Visit#4") { |school| school.fourth_visit.try(:visited_at) }
  end

  controller do
    def scoped_collection
      School.not_draft
    end
  end

end
