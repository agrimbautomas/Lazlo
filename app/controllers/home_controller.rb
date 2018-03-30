class HomeController < ApplicationController

  def index
    @home_page = Page.find_by_name 'Home'
    @most_liked_product = Product.last
    @most_purchased_product = Product.last
  end

  def cotizador
    @marvels = Marvel.all.order(:name)
  end

end
