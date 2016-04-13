ActiveAdmin.register Order do
  menu priority: 2

  permit_params :buyer_id, :product_id, :code, :detail, :order_status_id, :tracking_title, :payment

  config.per_page = 20

  filter :buyer
  filter :product
  filter :code

  #index(:row_class => -> record { 'my-class' if record.was_updated? }) do
  index(:row_class =>  -> record { OrderStatus.find(record.order_status_id).name_slug unless record.order_status_id.nil? }) do
    selectable_column

    column 'Nro' do |order|
      p order.id
    end
    column :buyer do |order|
      p order.buyer.name
    end
    column :product do |order|
      p order.product.name
    end
    column 'Estado', :class => 'status' do |order|
      OrderStatus.find(order.order_status_id).name unless order.order_status_id.nil?
    end
    column :payment do |order|
      '$' + order.payment.to_s
    end
    column 'Fecha Límite de Entrega' do |order|
      (order.created_at + 15.days).strftime("%m/%d")
    end
    column 'Imagen' do |order|
      image_tag(order.product.image.url(:thumb), :class => 'product-thumb')
    end

    actions
  end


  form do |f|
    f.inputs do
      f.input :buyer
      f.input :product
      f.input :order_status_id, :as => :select, include_blank: false,
              collection: OrderStatus.all, :label => 'Estado'
      f.input :detail, :hint => 'Algun tipo de detalle para la producción'
      f.input :payment, :input_html => {:min => 0, :step => 100}
      f.input :tracking_title, :hint => 'Titulo para mostrar en la página de trackeo',
              :label => 'Titulo para el tracking'
    end

    actions
  end


  show do |order|

    attributes_table_for order do
      row :buyer
      row :product

      row 'Tracking Link' do
        href = request.base_url + tracking_order_by_code_path(order.code)
        link_to href, href, target: '_blank'
      end
      row 'Status' do
        OrderStatus.find(order.order_status_id).name
      end
      row :detail
      row 'Título para Tracking' do
        order.tracking_title
      end
      row 'Imagen' do
        image_tag(order.product.image.url(:thumb))
      end
    end

  end
end
