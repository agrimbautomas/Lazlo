class MercadoPagoCartCheckout < MercadoPagoCheckout
  include Rails.application.routes.url_helpers

  attr_accessor :link

  def initialize(arguments)
	 super
	 @parameters = arguments.fetch :parameters
	 @user = @parameters['user']
	 @product_rows = @user.checkout_list.product_rows
  end

  private

  def purchase_data
	 {
		  'title' => purchase_title,
		  'product_rows' => strip_product_rows
	 }
  end

  def back_urls_json
	 product_row = @product_rows.first
	 {
		  'pending' => cart_checkout_success_url(product_row.product),
		  'success' => cart_checkout_pending_url(product_row.product),
		  'failure' => cart_checkout_cancelled_url(product_row.product)
	 }
  end

  def purchase_title
	 items_title = @items.map { |item| "#{item['quantity']} x #{item['title']}" }.join(', ')
	 I18n.t('checkout_purchase_title') + items_title
  end

  def items_to_json
	 set_purchase_items
	 @items.first['title'] = purchase_title
	 @items
  end


  def set_purchase_items
	 @items =[]
	 @product_rows.each do |product_row|
		@items << {
			 'id' => product_row.product.slug,
			 'title' => product_row.product.name,
			 'description' => product_row.product.description,
			 'quantity' => product_row.quantity,
			 'unit_price' => product_row.product.price,
			 'currency_id' => 'ARS',
			 'picture_url' => product_row.product.image.url
		}
	 end
  end


  def strip_product_rows
	 stripped_rows = []
	 @product_rows.each { |product_row| stripped_rows << {:id => product_row.id} }
	 stripped_rows.to_json
  end

end