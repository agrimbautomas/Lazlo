class CheckoutMercadoPago < Interactor
  include Rails.application.routes.url_helpers

  attr_accessor :link


  def initialize(arguments)
    super
    parameters = arguments.fetch :parameters
    @product_rows = parameters['product_rows']

  end

  def payment_link
    mp_response = $mp_client.create_preference(preference_data)


    $mp = MercadoPago.new('TEST-2261800553682324-062416-5428831c92810d51d28388c07905d49d__LD_LA__-130206835')
    $mp.post("/v1/payments", preference_data)
    Rails.env.development? ?  mp_response['response']['sandbox_init_point'] : mp_response['response']['init_point']
  end

  def preference_data
    {
        'items' => payment_items_json,
        'back_urls' => back_urls_json
    }

  end

  def payment_items_json
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


  def back_urls_json
    product_row = @product_rows.first
    {
        'pending' => product_purchase_success_url(product_row.product),
        'success' => product_purchase_pending_url(product_row.product),
        'failure' => product_purchase_failure_url(product_row.product)
    }
  end


end