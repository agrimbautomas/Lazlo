ActiveAdmin.register Product do
  menu priority: 1

  permit_params :name, :description, :price, :product_type_id, :image

  filter :name
  filter :price
  filter :created_at

  index do
    selectable_column

    column :name
    column 'Price' do |product|
      '$' + product.price.to_s
    end
    column 'Type' do |product|
      ProductType.find(product.product_type_id).name
    end
    column :created_at
    column :updated_at

    actions
  end


  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :product_type_id, :as => :select, include_blank: false, collection: ProductType.all
      f.input :image, :as => :file, :hint => image_tag(f.object.image.url(:thumb))
    end

    actions
  end

  show do |product|

    attributes_table_for product do
      row :name
      row :description
      row :price
      row :created_at
      row :image do
        image_tag(product.image.url(:medium))
      end

    end
  end

end
