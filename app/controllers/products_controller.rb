class ProductsController < ApplicationController
  def index
  end

  def show


    @table = Product.friendly.find(params[:id])
  end

  def tables
    @tables = Product.all
  end
end
