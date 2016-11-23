ActiveAdmin.register Category do
  menu parent: I18n.t('activerecord.models.product.other')

  permit_params :name, :image

  config.sort_order = 'name_asc'
  filter :name

  controller do
    defaults :finder => :find_by_slug
  end

  index do
    selectable_column

    column :name
    column :slug
    column :updated_at
    column :image do |category|
      image_tag(category.image.url(:thumb), :class => 'product-thumb')
    end

    actions
  end

  form do |f|
    f.inputs do
      f.input :name

      f.input :image, :as => :file, :hint => image_tag(f.object.image.url(:thumb))
    end

    actions
  end

  show do |category|
    attributes_table_for category do
      row :name
      row :image do
        image_tag(category.image.url(:medium))
      end
    end
  end


end