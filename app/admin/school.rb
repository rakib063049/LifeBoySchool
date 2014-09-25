ActiveAdmin.register School do
  permit_params :year, :unique_id, :state, :division_id, :district_id, :thana_id, :union_id, :title, :headmaster_name,
                :phone, :boys, :girls, :created_by, visits_attributes: [:id, :school_id, :agency_id, :quarter, :visited_at, :_destroy, images_attributes: [:id, :photo]]

  config.filters = false
  index do
    selectable_column
    id_column
    column :title
    column :unique_id
    column :headmaster_name
    column :phone
    column :created_at
    column :status

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
    actions
  end

  form do |f|
    f.inputs "School Details" do
      f.input :year, as: :select, collection: 2010..2050, prompt: "Please select Year"
      f.input :unique_id
      f.input :state, :input_html => {:value => f.object.state || 'Bangladesh'}, label: "Country"
      f.input :division_id, as: :select, collection: Division.all.collect { |c| [c.name, c.id] }, prompt: 'Please select Division'
      f.input :district_id, as: :select, collection: District.all.collect { |c| [c.name, c.id] }, prompt: 'Please select District'
      f.input :thana_id, as: :select, collection: Thana.all.collect { |c| [c.name, c.id] }, prompt: 'Please select Thana'
      f.input :union_id, as: :select, collection: Union.all.collect { |c| [c.name, c.id] }, prompt: 'Please select Union'
      f.input :title
      f.input :headmaster_name
      f.input :phone
      f.input :boys
      f.input :girls
      #f.input :created_by, as: :hidden, value: current_user.id
    end

    f.inputs "Visits" do
      f.has_many :visits do |vf|
        vf.inputs "Details" do
          vf.input :agency_id, as: :select, collection: Agency.all.collect { |c| [c.name, c.id] }, prompt: 'Please select Agency'
          vf.input :quarter, as: :select, collection: Visit::QUARTER, prompt: 'Please select Quarter'
          vf.input :visited_at, as: :datepicker
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
