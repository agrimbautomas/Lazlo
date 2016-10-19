class ProductsController < ApplicationController
  before_filter :set_request

  def index
  end

  def show
    @table = Product.friendly.find(params[:id])
    @image_uri = URI.join(request.url, @table.image.url)

  end


  def purchase
    @product = Product.find(params[:id])

    Order.create(product: params[:id])
  end


  def set_request
    $request = request
  end

end
