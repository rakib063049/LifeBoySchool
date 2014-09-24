ActiveAdmin.register Visit do
  permit_params :school_id, :agency_id, :quarter, :visited_at, :created_by, :approve, images_attributes: [:photo]

  index do
    selectable_column
    id_column
    column :school_id
    column :agency_id
    column :quarter
    column :visited_at
    actions
  end

  filter :school_id
  filter :agency_id

  form do |f|
    f.inputs "Visit Details" do
      f.input :school_id, as: :select, collection: School.all.collect { |c| [c.title, c.id] }, prompt: 'Please select School'
      f.input :agency_id, as: :select, collection: Agency.all.collect { |c| [c.name, c.id] }, prompt: 'Please select Agency'
      f.input :quarter, as: :select, collection: Visit::QUARTER, prompt: 'Please select Quarter'
      f.input :visited_at, as: :datepicker
    end

    f.inputs "Images" do
      f.has_many :images, allow_destroy: true do |cf|
        cf.input :photo, as: :file
      end
    end

    f.actions
  end

  sidebar "School Details", :only => :show do
    attributes_table_for visit.school, :title, :headmaster_name, :phone
  end

  sidebar "Photos", :only => :show do
    attributes_table_for visit.images do
      row("#{visit.images.count} Photos") { |img| image_tag img.photo.url(:thumb) }
    end
  end
end

