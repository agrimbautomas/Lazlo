class ProductsController < ApplicationController
  before_filter :set_request

  def index
  end

  def show
    @product = Product.friendly.find(params[:id])
    @image_uri = URI.join(request.url, @product.image.url)
    @category = Category.friendly.find(@product.category_id)
  end


  def purchase
    @product = Product.find(params[:id])

    Order.create(product: params[:id])
  end


  def set_request
    $request = request
  end

end
