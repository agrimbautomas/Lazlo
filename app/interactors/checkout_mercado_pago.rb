class CheckoutMercadoPago < Interactor
  include Rails.application.routes.url_helpers

  attr_accessor :link

  def initialize(arguments)
	 super
	 @parameters = arguments.fetch :parameters
	 @user = @parameters['user']
  end

  def cart_checkout
	 @product_rows = @user.checkout_list.product_rows
	 payment_link cart_checkout_preference_data
  end

  def single_checkout
	 @product = @parameters['product']
	 single_product_row = ProductRow.create(product: @product, quantity: 1)
	 @user.checkout_list.product_rows << single_product_row
	 @product_rows = [single_product_row]
	 payment_link cart_checkout_preference_data
  end

  def payment_link preference_data
	 mp_response = $mp_client.create_preference(preference_data)
	 Rails.env.development? ? mp_response['response']['sandbox_init_point'] : mp_response['response']['init_point']
  end

  private

  def payment_items_json
	 items = purchase_items
	 items.first['title'] = purchase_title items
	 items
  end

  def purchase_items
	 items =[]
	 @product_rows.each do |product_row|
		items << {
			 'id' => product_row.product.slug,
			 'title' => product_row.product.name,
			 'description' => product_row.product.description,
			 'quantity' => product_row.quantity,
			 'unit_price' => product_row.product.price,
			 'currency_id' => 'ARS',
			 'picture_url' => product_row.product.image.url
		}
	 end
	 items
  end

  def purchase_title items
	 items_title = items.map {|item| "#{item['quantity']} x #{item['title']}"}.join(', ')
	 I18n.t('checkout_purchase_title') + items_title
  end

  def cart_checkout_preference_data
	 {
		  'items' => payment_items_json,
		  'back_urls' => back_urls_json,
		  'payer' => payer_data,
		  'additional_info' => purchase_data
	 }
  end

  def purchase_data
	 {
		  'title' => purchase_title(purchase_items)
	 }
  end

  def payer_data
	 {
		  'name' => @user.name,
		  'email' => @user.email
	 }
  end

  def back_urls_json
	 product_row = @product_rows.first
	 {
		  'pending' => product_purchase_success_url(product_row.product),
		  'success' => product_purchase_pending_url(product_row.product),
		  'failure' => product_purchase_failure_url(product_row.product)
	 }
  end


end