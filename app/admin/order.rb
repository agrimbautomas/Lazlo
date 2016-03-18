ActiveAdmin.register Order do
  menu priority: 2

  permit_params :buyer_id, :product_id, :code, :detail, :order_status_id, :tracking_title, :payment

  filter :buyer
  filter :product
  filter :code

  index do
    selectable_column

    column 'Nro' do |order|
      p order.id
    end
    column 'Comprador' do |order|
      p order.buyer.name
    end
    column 'Producto' do |order|
      p order.product.name
    end
    column 'Statado' do |order|
      OrderStatus.find(order.order_status_id).name
    end
    column 'A Cobrar' do |order|
      '$' + order.payment.to_s
    end
    column 'Fecha de Ingreso' do |order|
      order.created_at.strftime("%m/%d/%Y")
    end

    actions
  end


  form do |f|
    f.inputs do
      f.input :buyer, :label => 'Comprador'
      f.input :product, :label => 'Producto'
      f.input :order_status_id, :as => :select, include_blank: false,
              collection: OrderStatus.all, :label => 'Estado'
      f.input :detail, :hint => 'Algun tipo de detalle para la producción', :label => 'Detalle'
      f.input :payment, :label => 'A cobrar', :input_html => {:min => 0, :step => 100}
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
      row :tracking_title
    end

  end
end