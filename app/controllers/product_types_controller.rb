class ProductTypesController < ApplicationController
  before_filter :set_request

  def show
    @product_type = ProductType.friendly.find(params[:id])
    @products = Product.where(product_type_id: @product_type)


  end


  def purchase
    @product = Product.find(params[:id])

    Order.create(product: params[:id])
  end


  def set_request
    $request = request
  end

end
