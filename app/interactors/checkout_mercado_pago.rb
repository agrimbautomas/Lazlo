class CheckoutMercadoPago < Interactor
  include Rails.application.routes.url_helpers

  attr_accessor :link


  def initialize(arguments)
    super
    parameters = arguments.fetch :parameters
    @product_rows = parameters['product_rows']
    payment_link
  end

  def payment_link
    $mp_client.create_preference(preference_data)
  end

  def preference_data
    {
        'items' => payment_items,
        'back_urls' => {
            'pending' => product_purchase_success_url(self),
            'success' => product_purchase_pending_url(self),
            'failure' => product_purchase_failure_url(self)
        }
    }
  end

  def payment_items
    items =[]
    @product_rows.each do |product_row|
      items << [
          'title' => product_row.product.name,
          'description' => product_row.product.description,
          'quantity' => product_row.quantity,
          'unit_price' => product_row.product.price,
          'currency_id' => 'ARS',
          'picture_url' => product_row.product.image_uri]
    end
    items
  end


end