ActiveAdmin.register School do
  permit_params :year, :unique_id, :state, :division_id, :district_id, :thana_id, :union, :title, :headmaster_name, :agency_id, :quarter, :honorific, :mobile, :data_entry_operator,
                :phone, :boys, :girls, :created_by, visits_attributes: [:id, :school_id, :agency_id, :quarter, :visited_at, :_destroy, acknowledgement_certificates_attributes: [:id, :photo, :_destroy],
                                                                        images_attributes: [:id, :photo, :_destroy]], completion_certificates_attributes: [:id, :photo, :_destroy]

  filter :year
  filter :created_at, label: 'Data Entry Date'
  filter :division
  filter :district
  filter :title


  index do
    selectable_column
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
    actions
  end

  show do
    render "show"
  end

  sidebar "Completion Certificate", :only => :show do
    render "completion_certificates"
  end

  sidebar "Visit Details", :only => :show do
    render "show_visits"
  end

  form do |f|
    f.inputs "School Details" do
      f.input :year, as: :select, collection: 2014..2015, prompt: "Please select Year"
      f.input :agency_id, as: :select, collection: Agency.all.collect { |c| [c.name, c.id] }, prompt: 'Please select Agency'
      f.input :quarter, as: :select, collection: Visit::QUARTER, prompt: 'Please select Quarter'
      f.input :state, :input_html => {:value => f.object.state || 'Bangladesh'}, label: "Country"
      f.input :division_id, as: :select, collection: Division.all.collect { |c| [c.name, c.id] }, prompt: 'Please select Division'
      f.input :district_id, as: :select, :input_html => {'data-option-dependent' => true,
                                                         'data-option-url' => '/schools/districts?division_id=:school_division_id',
                                                         'data-option-observed' => 'school_division_id'}, prompt: 'Please select District',
              collection: (f.object.division ? f.object.division.districts.collect { |district| [district.name, district.id] } : [])
      f.input :thana_id, as: :select, :input_html => {'data-option-dependent' => true,
                                                      'data-option-url' => '/schools/thanas?district_id=:school_district_id',
                                                      'data-option-observed' => 'school_district_id'}, prompt: 'Please select Thana',
              collection: (f.object.division ? f.object.district.thanas.collect { |thana| [thana.name, thana.id] } : [])

      f.input :union
      f.input :title, label: 'School Name'
      f.inputs "Completion Certificate" do
        f.has_many :completion_certificates, allow_destroy: true do |cf|
          cf.input :photo, :as => :file, :hint => cf.template.image_tag(cf.object.photo.url(:thumb))
        end
      end
      f.input :honorific, label: 'Headmaster Title', as: :select, collection: ["Mr.", "Ms.", "Mrs."], prompt: "Please select title"
      f.input :headmaster_name
      f.input :phone
      f.input :mobile, :input_html => {:value => f.object.mobile || '+88'}
      f.input :boys
      f.input :girls
      f.input :data_entry_operator
      f.input :created_by, as: :hidden, :input_html => {value: current_user.id}
    end

    f.inputs "Visits" do
      f.has_many :visits do |vf|
        vf.input :visited_at, as: :datepicker
        vf.inputs "Acknowledgement Certificate" do
          vf.has_many :acknowledgement_certificates, allow_destroy: true do |cf|
            cf.input :photo, :as => :file, :hint => cf.template.image_tag(cf.object.photo.url(:thumb))
          end
        end
        vf.inputs "Images" do
          vf.has_many :images, allow_destroy: true do |cf|
            cf.input :photo, :as => :file, :hint => cf.template.image_tag(cf.object.photo.url(:thumb))
          end
        end
      end
    end


    f.actions
  end


  action_item :only => [:show], :if => proc { current_user.admin? && resource.pending? } do
    link_to('Approve!', approve_admin_school_path(resource), method: :put)
  end

  member_action :approve, :method => :put do
    school = School.find(params[:id])
    school.approve!
    flash[:notice] = "School has been Approved!"
    redirect_to [:admin, :schools]
  end

end
