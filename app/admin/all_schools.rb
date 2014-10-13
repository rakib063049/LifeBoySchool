ActiveAdmin.register School, :as => 'AllSchool' do
  menu :if => proc { current_user.admin? }
  config.filters = false
  config.batch_actions = false
  config.clear_action_items!

  index :download_links => proc { current_user.admin? } do
    column("Implementing Agency") { |school| school.agency.try(:name) }
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


    column("Data Entry Operator") { |school| school.data_entry_operator }
    column("Data Entry Date") { |school| formated_date(school.created_at) }
  end

  controller do
    def scoped_collection
      School.not_draft
    end
  end

end
