ActiveAdmin.register Thana do
  permit_params :name, :district_id

  index do
    selectable_column
    id_column
    column :name
    column :district_id
    actions
  end

  filter :name
  filter :district_id

  form do |f|
    f.inputs "Thana Details" do
      f.input :name
      f.input :district_id, as: :select, collection: District.all.collect { |c| [c.name, c.id] }, prompt: 'Please select District'
    end
    f.actions
  end

end

