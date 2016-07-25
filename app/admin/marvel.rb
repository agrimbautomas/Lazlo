ActiveAdmin.register Marvel do
  menu priority: 4

  permit_params :name, :price

  config.sort_order = 'name_asc'
  filter :name

  index do
    selectable_column

    column :name
    column :price, :hint => 'Por de mármol en 100x100'
    column :updated_at

    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
    end

    actions
  end

  show do |marvel|
    attributes_table_for marvel do
      row :name
      row :price do
        '$'+marvel.price.to_s
      end

    end
  end


end