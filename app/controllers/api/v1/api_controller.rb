class  Api::V1::ApiController < RocketPants::Base
  version 1

  def purchase_product_data
    @table = Product.friendly.find(params[:product_id])

    @table.set_quantity ( params[:quantity].present? ? params[:quantity].to_i : 1)

    expose @table.payment
  end

end
