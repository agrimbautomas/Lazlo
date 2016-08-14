class ProductsController < ApplicationController
  before_filter :set_request

  def index
  end

  def show
    @table = Product.friendly.find(params[:id])
    @image_uri = URI.join(request.url, @table.image.url)

  end

  def by_slug
    @product_type = ProductType.friendly.find(params[:product_type_slug])
    @products = Product.where(product_type_id: @product_type)
    render 'index'
  end

  def tables
    @tables = Product.all
  end


  def purchase
    @product = Product.find(params[:id])

    Order.create(product: params[:id])
  end


  def set_request
    $request = request
  end

end
