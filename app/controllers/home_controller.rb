class HomeController < ApplicationController
  include ApplicationHelper

  def index
    @home_page = Page.find_by_name 'Home'
    @featured_products = Product.featured
  end

  def cotizador
    @marvels = Marvel.all.order(:name)
  end

end
