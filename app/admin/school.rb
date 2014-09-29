ActiveAdmin.register School do
  permit_params :year, :unique_id, :state, :division_id, :district_id, :thana_id, :union, :title, :headmaster_name, :agency_id, :quarter, :honorific, :mobile, :data_entry_operator,
                :phone, :boys, :girls, :created_by, visits_attributes: [:id, :school_id, :agency_id, :quarter, :visited_at, :_destroy, acknowledgement_certificates_attributes: [:id, :photo],
                                                                        images_attributes: [:id, :photo]], completion_certificates_attributes: [:id, :photo]

  config.filters = false
  index do
    selectable_column
    column :year
    column :agency
    column :quarter
    #column("School Id") { |school| school.unique_id }
    #column("Country") { |school| school.state }
    column :division
    column :district
    column :thana
    column :union
    column("School Name") { |school| school.title }
    #column :headmaster
    column :phone
    column :mobile
    column :status
    #column :boys
    #column :girls
    column :total_students
    #column :data_entry_operator
    #column :visits do |school|
    #  table_for school.visits.order('id ASC') do
    #    column :id do |visit|
    #      link_to visit.id, [:admin, visit]
    #    end
    #    column :visited_at
    #  end
    #end
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
        f.has_many :completion_certificates do |cf|
          cf.input :photo, as: :file
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
          vf.has_many :acknowledgement_certificates do |cf|
            cf.input :photo, as: :file
          end
        end
        vf.inputs "Images" do
          vf.has_many :images do |cf|
            cf.input :photo, as: :file
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
