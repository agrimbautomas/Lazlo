ActiveAdmin.register Order do
  menu priority: 2

  permit_params :buyer_id, :product_id, :code, :detail, :order_status_id, :tracking_title, :payment, :color

  config.per_page = 20

  filter :buyer
  filter :product
  filter :code


  controller do

    def scoped_collection
      return Order.all if current_admin_user.has_role? :full_admin
      #return AdminUser.where(company_id: current_admin_user.company_id) if current_admin_user.has_role? :blacksmith
      return Order.where(order_status_id: [2, 3]) if current_admin_user.has_role? :blacksmith
    end

    def update
      if params[:status].present?
        resource.update_attribute(:order_status_id, params[:status].to_f + 1)
        redirect_to admin_orders_path
      else
        super do |format|
        end
      end

    end

  end

  #index(:row_class => -> record { 'my-class' if record.was_updated? }) do
  index(:row_class => -> record { OrderStatus.find(record.order_status_id).name_slug unless record.order_status_id.nil? }) do
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

    column :color do |order|
      p order.color
    end

    column 'Estado', :class => 'status' do |order|
      OrderStatus.find(order.order_status_id).name unless order.order_status_id.nil?
    end

    column :payment do |order|
      '$' + order.payment.to_s
    end if current_admin_user.has_role? :full_admin

    column 'Fecha Límite de Entrega' do |order|
      (order.created_at + 15.days).strftime("%m/%d")
    end if current_admin_user.has_role? :full_admin

    column 'Imagen' do |order|
      image_tag(order.product.image.url(:thumb), :class => 'product-thumb')
    end

    if current_admin_user.has_role? :blacksmith
      column :actions do |order|
        links = link_to I18n.t('active_admin.view'), resource_path(order)
        links += ' '
        links += link_to 'Terminada!', admin_order_path(order, :status => order.order_status_id),
                         class: 'finished-button', method: :put if order.order_status_id == 2
        links
      end
    else
      actions
    end

  end


  form do |f|
    f.inputs do
      f.input :buyer, collection: Buyer.order(updated_at: :desc)
      f.input :product
      f.input :order_status_id, :as => :select, include_blank: false,
              collection: OrderStatus.all, :label => 'Estado'
      f.input :color, :as => :string
      f.input :detail, :hint => 'Algun tipo de detalle para la producción'
      f.input :payment, :input_html => {:min => 0, :step => 100} if current_admin_user.has_role? :full_admin
      f.input :tracking_title, :hint => 'Titulo para mostrar en la página de trackeo',
              :label => 'Titulo para el tracking' if current_admin_user.has_role? :full_admin
    end

    actions
  end


  show do |order|

    attributes_table_for order do
      row :buyer
      row :product
      row :color

      row 'Tracking Link' do
        href = request.base_url + tracking_order_by_code_path(order.code)
        link_to href, href, target: '_blank'
      end
      row 'Status' do
        OrderStatus.find(order.order_status_id).name
      end
      row :payment do |order|
        '$' + order.payment.to_s
      end if current_admin_user.has_role? :full_admin
      row :detail
      row 'Título para Tracking' do
        order.tracking_title
      end if current_admin_user.has_role? :full_admin

      row 'Imagen' do
        image_tag(order.product.image.url(:thumb))
      end
    end

  end
end
