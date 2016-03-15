ActiveAdmin.register OrderStatus do
  menu priority: 5

  permit_params :name, :image

  form do |f|
    f.inputs do
      f.input :name
      f.input :image, :as => :file, :hint => image_tag(f.object.image.url(:thumb))
    end

    actions
  end

  index do
    selectable_column

    column :name
    column :image do |order_status|
      image_tag(order_status.image.url(:thumb))
    end
    actions
  end

  show do |order_status|

    attributes_table_for order_status do
      row :name
      row :image do
        image_tag(order_status.image.url(:thumb))
      end

    end
  end
end
