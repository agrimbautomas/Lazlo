class ProductsController < ApplicationController
  def index
  end

  def show
  end

  def tables
    @tables = Product.all
  end
end
