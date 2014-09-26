ActiveAdmin.register Division do
  permit_params :name
  menu false

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs "Division Details" do
      f.input :name
    end
    f.actions
  end

end


