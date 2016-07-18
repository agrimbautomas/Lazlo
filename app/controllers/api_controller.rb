class ApiController < RocketPants::Base

  def purchase_product_data
    @table = Product.friendly.find(params[:product_id])

    @table.set_quantity ( params[:quantity].present? ? params[:quantity].to_i : 1)

    expose @table.payment
  end

end
