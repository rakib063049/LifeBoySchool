ActiveAdmin.register Union do
  permit_params :name, :thana_id

  index do
    selectable_column
    id_column
    column :name
    column :thana_id
    actions
  end

  filter :name
  filter :thana_id

  form do |f|
    f.inputs "Union Details" do
      f.input :name
      f.input :thana_id, as: :select, collection: Thana.all.collect { |c| [c.name, c.id] }, prompt: 'Please select Thana'
    end
    f.actions
  end

end

