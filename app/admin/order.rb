ActiveAdmin.register Order do

  menu priority: 2

  permit_params :buyer_id, :user_id, :detail, :order_status_id, :title,
					 :payment, order_products_rows_attributes: [:product_id, :quantity, :product_name, :product_price, :_destroy]

  config.per_page = 20

  filter :buyer
  filter :product
  filter :code

  before_action :repair_nested_params

  #
  # Config
  #
  OrderStatus.all.each do |order_status|
	 scope order_status.name do
		Order.where(:order_status => order_status)
	 end
  end

  controller do

	 def scoped_collection
		Order.includes(:order_products_rows)
		return Order.all if current_admin_user.has_role? :full_admin
		return Order.where(order_status_id: [2, 3]) if current_admin_user.has_role? :blacksmith
	 end

	 def create
		new_order = Order.new
		new_order.create_order_products_list

		params[:order_params] = order_params
		params[:order] = new_order

		new_order = SaveAdminOrder.(params).save_or_update_order
		@order = new_order
		@object = new_order

		if new_order.invalid?
		  display_resource_errors new_order
		else
		  super
		end
	 end

	 def update
		params[:order_params] = order_params
		params[:order] = resource

		updated_order = SaveAdminOrder.(params).save_or_update_order

		if updated_order.invalid?
		  display_resource_errors(updated_order)
		else
		  @order.save!
		  redirect_to admin_order_path(updated_order)
		end
	 end

	 def display_resource_errors order
		if order.invalid?

		  flash[:error] = SaveAdminOrder.errors_message order
		  redirect_to :back
		end
	 end


	 def order_params
		permitted_params.require(:order)
	 end

  end

  #
  # Index
  #
  index(:row_class => -> record { OrderStatus.find(record.order_status_id).name_slug unless record.order_status_id.nil? }) do
	 selectable_column

	 column :id

	 column :buyer do |order|
		if order.buyer.present?
		  link_to order.buyer.name, admin_buyer_path(order.buyer)
		elsif order.user.present?
		  link_to order.user.name, admin_user_path(order.user)
		end
	 end

	 column :title do |order|
		p order.title.split.slice(0, 7).join(' ')
	 end

	 column 'Pago' do |order|
		span I18n.t("mercado_pago_purchase.order_status.#{order.mercado_pago_purchase.status}") unless order.mercado_pago_purchase.nil?
	 end

	 column 'Orden' do |order|
		order.order_status
	 end


	 column :payment do |order|
		 format_price order.payment
	 end if current_admin_user.has_role? :full_admin

	 column 'Límite' do |order|
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
		# Todo refactor - 'code' as select input to choose buyer type
		is_user_checked = f.object.user.present?

		f.input :code, :as => :radio, :collection => [
							  ['Usuario creado desde el Admin', 'buyer', {:checked => !is_user_checked}],
							  ['Usuario de la Web', 'user', {:checked => is_user_checked}]
						 ],
				  :label => 'Origen del comprador'
		f.input :buyer, collection: Buyer.order(updated_at: :desc)
		f.input :user, collection: User.order(updated_at: :desc)
		f.input :order_status_id, :as => :select, include_blank: false,
				  collection: OrderStatus.all, :label => 'Estado'
		f.input :detail, :hint => 'Algun tipo de detalle para la producción'
		f.input :payment, :input_html => {:min => 0, :step => 100} if current_admin_user.has_role? :full_admin
		f.input :title, :hint => 'Titulo de la orden (se muestra en el tracking)',
				  :label => 'Titulo de la orden' if current_admin_user.has_role? :full_admin
	 end


	 inputs 'Detalle de los productos' do
		f.semantic_errors *f.object.errors.keys
		f.has_many :order_products_rows, new_record: true do |a|
		  a.input :product_id, :as => :select, include_blank: true,
					 collection: Product.all.order('name asc').map { |product| [product.name, product.id, price: product.price.to_i] },
					 :label => t('activerecord.models.product.one'), :input_html => {:class => 'order-product-row-product'}
		  a.input :quantity,  :label => t('activerecord.attributes.order_products_rows.quantity'),
					 :input_html => {:value => a.object.quantity || 1, :class => 'order-product-row-product-quantity'}
		  a.input :product_price, :label => t('activerecord.attributes.order_products_rows.product_price'),
					 :input_html => {:class => 'order-product-row-product-price', :alt => '0'}
		  a.input :product_name, as: :hidden,
					 :input_html => {:class => 'order-product-row-product-name', readonly: true}
		  a.template.concat "<li class='total-row-price'><label>Total</label>$<span>0</span></li>".html_safe
		  a.input :_destroy, :as => :boolean, :required => false, :label => 'Borrar Producto(s)',
					 :input_html => {:class => 'remove-product-row'}
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

		row :payment do |order|
			format_price order.payment
		end if current_admin_user.has_role? :full_admin

		row 'Tracking Link' do
		  href = request.base_url + tracking_order_by_code_path(order.code)
		  link_to href, href, target: '_blank'
		end

		row 'Status' do |order|
		  order.order_status
		end

		row I18n.t('created_at') do |order|
		  order.created_at
		end

		row :detail

		row 'Título para Tracking' do
		  order.title
		end if current_admin_user.has_role? :full_admin

	 end

	 br
	 br

	 h4 'Detalle del pago de la Orden de Mercado Pago' unless order.mercado_pago_purchase.nil?
	 attributes_table_for order do

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
			  format_price order_products_row.total
		  end

		  column I18n.t('activerecord.models.product_image.one') do |order_products_row|
			 image_tag(order_products_row.product.image.url(:thumb)) unless order_products_row.product.image.nil?
		  end

		end
	 end

  end

end
