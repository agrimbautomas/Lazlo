class HomeController < ApplicationController

  def index
    @home_page = Page.find_by_name 'Home'
    @featured_products = Product.featured.visible
  end

  def cotizador
    @marvels = Marvel.all.order(:name)
  end

end
