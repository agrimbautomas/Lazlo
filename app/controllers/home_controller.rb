class HomeController < ApplicationController
  include ApplicationHelper

  def index
    @home_page = Page.find_by_name 'Home'
  end

  def show
  end



  def cotizador
    @marvels = Marvel.all.order(:name)
  end


end
