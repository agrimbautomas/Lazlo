ActiveAdmin.register OrderStatus do
  menu priority: 10, parent: I18n.t('config')

  permit_params :name, :priority, :visible, :image

  config.sort_order = 'priority_asc'
  filter :name

  index do
    selectable_column

    column :name
    column :priority, :hint => 'Orden en el que aparecen en el Tracking'
    column :visible, :hint => 'Visible para el usuario'
	 column :image do |ordrer_status|
		image_tag(ordrer_status.image.url(:thumb))
	 end
    column :updated_at

    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :priority
      f.input :visible
		f.input :image, :as => :file, :hint => image_tag(f.object.image.url(:thumb))
    end

    actions
  end

  show do |ordrer_status|
    attributes_table_for ordrer_status do
      row :name
      row :priority
      row :visible
		row :image do
		  image_tag(ordrer_status.image.url(:medium))
		end
    end
  end


end