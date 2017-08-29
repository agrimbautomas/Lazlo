ActiveAdmin.register Order do
  menu priority: 2

  permit_params :buyer_id, :user_id, :code, :detail, :order_status_id, :title,
					 :payment, order_products_rows_attributes: [:id, :picture, :_destroy]

  config.per_page = 20

  filter :buyer
  filter :product
  filter :code

  controller do

	 def scoped_collection
		Order.includes(:order_products_rows)
		return Order.all if current_admin_user.has_role? :full_admin
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

  index(:row_class => -> record {OrderStatus.find(record.order_status_id).name_slug unless record.order_status_id.nil?}) do
	 selectable_column

	 column 'Nro' do |order|
		p order.id
	 end

	 column :buyer do |order|
		if order.buyer.present?
		  link_to order.buyer.name, admin_buyer_path(order.buyer)
		elsif order.user.present?
		  link_to order.user.name, admin_user_path(order.user)
		end
	 end

	 column :title do |order|
		p order.title
	 end

	 column 'Estado del Pago' do |order|
		I18n.t("mercado_pago_purchase.order_status.#{order.mercado_pago_purchase.status}") unless order.mercado_pago_purchase.nil?
	 end
	 column 'Estado de la Orden', :class => 'status' do |order|
		order.order_status
	 end


	 column :payment do |order|
		'$' + order.payment.to_s
	 end if current_admin_user.has_role? :full_admin

	 column 'Fecha Límite' do |order|
		(order.created_at + 15.days).strftime("%m/%d")
	 end if current_admin_user.has_role? :full_admin

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
		f.input :buyer, collection: Buyer.order(updated_at: :desc) unless order.buyer.nil?
		f.input :user, collection: User.order(updated_at: :desc) unless order.user.nil?
		f.input :order_status_id, :as => :select, include_blank: false,
				  collection: OrderStatus.all, :label => 'Estado'
		f.input :detail, :hint => 'Algun tipo de detalle para la producción'
		f.input :payment, :input_html => {:min => 0, :step => 100} if current_admin_user.has_role? :full_admin
		f.input :title, :hint => 'Titulo de la orden (se muestra en el tracking)',
				  :label => 'Titulo de la orden' if current_admin_user.has_role? :full_admin
	 end


	 inputs do
		f.has_many :order_products_rows, new_record: true do |a|
		  a.input :product_id, :as => :select, include_blank: false,
					 collection: Product.all, :label => 'Producto'
		  a.input :quantity
		end
	 end


	 actions

  end


  show do |order|
	 h4 'Detalle de la Orden'
	 attributes_table_for order do
		row t('activerecord.models.buyer.one') do
		  order.buyer.present? ? order.buyer : order.user
		end

		row 'Tracking Link' do
		  href = request.base_url + tracking_order_by_code_path(order.code)
		  link_to href, href, target: '_blank'
		end

		row 'Status' do |order|
		  order.order_status
		end

		row :detail

		row 'Título para Tracking' do
		  order.title
		end if current_admin_user.has_role? :full_admin

	 end

	 br
	 br

	 h4 'Detalle del pago de la Orden'
	 attributes_table_for order do
		row 'Monto' do |order|
		  '$' + order.payment.to_s
		end if current_admin_user.has_role? :full_admin

		row 'Estado del pago' do |order|
		  I18n.t("mercado_pago_purchase.order_status.#{order.mercado_pago_purchase.status}") unless order.mercado_pago_purchase.nil?
		end if current_admin_user.has_role? :full_admin

		row 'Tipo de pago' do |order|
		  I18n.t("mercado_pago_purchase.payment_type.#{order.mercado_pago_purchase.payment_type}")
		end if current_admin_user.has_role? :full_admin

	 end unless order.mercado_pago_purchase.nil?

	 br
	 br

	 panel 'Productos en la orden' do
		table_for(order.order_products_rows) do

		  column t('activerecord.models.product.one') do |order_products_row|
			 link_to order_products_row.product_name, product_path(order_products_row.product)
		  end

		  column t('quantity') do |order_products_row|
			 order_products_row.quantity
		  end

		  column t('total') do |order_products_row|
			 order_products_row.formatted_total
		  end

		  column I18n.t('activerecord.models.product_image.one') do |order_products_row|
			 image_tag(order_products_row.product.image.url(:thumb)) unless order_products_row.product.image.nil?
		  end

		end
	 end

  end
end
