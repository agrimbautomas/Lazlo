ActiveAdmin.register Product do
  menu priority: 1, parent: I18n.t('activerecord.models.product.other')



  permit_params :name, :description, :price, :category_id, :image
  config.sort_order = 'name_asc'
  config.per_page = 20

  filter :name
  filter :price

  controller do
    defaults :finder => :find_by_slug
  end


  index do
    selectable_column

    column :name
    column :price do |product|
      '$' + product.price.to_s
    end
    column 'Categoria' do |product|
      Category.find(product.category_id).name unless product.category_id.nil?
    end
    column :image do |product|
      image_tag(product.image.url(:thumb), :class => 'product-thumb')
    end

    actions
  end


  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :category_id, :as => :select, include_blank: false,
              collection: Category.all, label: 'Tipo de producto'
      f.input :image, :as => :file, :hint => image_tag(f.object.image.url(:thumb))
    end

    actions
  end

  show do |product|

    attributes_table_for product do
      row :name
      row :description
      row :price
      row 'Tipo de producto' do
        Category.find(product.category_id).name
      end
      row :image do
        image_tag(product.image.url(:medium))
      end

    end
  end

end
