ActiveAdmin.register Order do
  menu priority: 2

  permit_params :buyer_id, :product_id, :code, :detail, :order_status_id

  filter :buyer
  filter :product
  filter :code

  index do
    selectable_column

    column :buyer
    column :product
    column 'Status' do |order|
      OrderStatus.find(order.order_status_id).name
    end
    column :code
    column :created_at

    actions
  end


  form do |f|
    f.inputs do
      f.input :buyer
      f.input :product
      f.input :order_status_id, :as => :select, include_blank: false,
              collection: OrderStatus.all
      f.input :detail
    end

    actions
  end


  show do |order|

    attributes_table_for order do
      row :buyer
      row :product
      row :code
      row 'Status' do
        OrderStatus.find(order.order_status_id).name
      end
      row :detail
    end

  end
end
