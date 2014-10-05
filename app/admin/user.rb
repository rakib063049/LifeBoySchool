ActiveAdmin.register User do
  permit_params :first_name, :last_name, :title, :agency_id, {roles: []}, :roles_mask, :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column("Implementing Agency") { |user| user.agency.try(:name) }
    column :first_name
    column :last_name
    column :email
    column :role do |u|
      u.roles.join(",")
    end
    column :created_at
    actions
  end

  filter :email
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :agency_id, as: :select, :required => true, collection: Agency.all.collect { |c| [c.name, c.id] }, prompt: 'Please select Agency'
      f.input :first_name
      f.input :last_name
      f.input :title
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :roles, as: :check_boxes, collection: User::ROLES
    end
    f.actions
  end

end
