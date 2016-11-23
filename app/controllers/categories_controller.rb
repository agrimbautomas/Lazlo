class CategoriesController < ApplicationController
  before_filter :set_request

  def show
    @category = Category.friendly.find(params[:id])
    @products = Product.where(category_id: @category)
  end


  def purchase
    @product = Product.find(params[:id])

    Order.create(product: params[:id])
  end


  def set_request
    $request = request
  end

end
