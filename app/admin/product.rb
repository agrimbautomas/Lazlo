ActiveAdmin.register Product do

  permit_params :name, :description, :price, :type, :image

  filter :name
  filter :price
  filter :created_at

  index do
    selectable_column

    column :name
    column 'Price' do |product|
      '$' + product.price.to_s
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
