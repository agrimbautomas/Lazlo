ActiveAdmin.register Category do
  menu parent: I18n.t('activerecord.models.product.other')

  permit_params :name, :description, :slug, :image

  config.sort_order = 'name_asc'
  filter :name

  controller do
    defaults :finder => :find_by_slug
  end

  index do
    selectable_column

    column :name
    column :slug
    column :image do |category|
      image_tag(category.image.url(:thumb), :class => 'product-thumb')
    end
    column :views

    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :image, :as => :file, :hint => image_tag(f.object.image.url(:thumb))
    end

    actions
  end

  show do |category|
    attributes_table_for category do
      row :name
      row :description
      row 'Link' do
        link_to category_url, category_path
      end
      row :image do
        image_tag(category.image.url(:medium))
      end
      row :views
    end
  end


end