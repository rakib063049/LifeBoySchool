ActiveAdmin.register District do
  permit_params :name, :division_id
  menu false

  index do
    selectable_column
    id_column
    column :name
    column :division_id
    actions
  end

  filter :name
  filter :division_id

  form do |f|
    f.inputs "District Details" do
      f.input :name
      f.input :division_id, as: :select, collection: Division.all.collect { |c| [c.name, c.id] }, prompt: 'Please select Division'
    end
    f.actions
  end

end


