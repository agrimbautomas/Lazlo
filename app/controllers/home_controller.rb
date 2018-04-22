class HomeController < ApplicationController

  def index
    @home_page = Page.find_by_name 'Home'
    @most_liked_product = Product.most_viewed
    @most_purchased_product = Product.order('RAND()').first
  end

  def cotizador
    @marvels = Marvel.all.order(:name)
  end

end
