class MercadoPagoSingleCheckout < MercadoPagoCheckout

  attr_accessor :link

  def initialize(arguments)
	 super
	 @parameters = arguments.fetch :parameters
	 @user = @parameters['user']
	 @product = @parameters['product']
  end

  private

  def items_to_json
	 [{
			'id' => @product.slug,
			'title' => @product.name,
			'description' => @product.description,
			'quantity' => 1,
			'unit_price' => @product.price,
			'currency_id' => 'ARS',
			'picture_url' => @product.image.url
	  }]
  end

  def purchase_title
	 @product.name
  end

  def back_urls_json
	 {
		  'pending' => single_checkout_success_url(@product),
		  'success' => single_checkout_pending_url(@product),
		  'failure' => single_checkout_cancelled_url(@product)
	 }
  end

  def purchase_data
	 {
		  'product' => strip_product
	 }
  end

  def strip_product
	 {:id => @product.id, :name => @product.name}.to_json
  end

end