class UsersController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!
  before_action :set_product, only: [:add_product_to_wish_list]

  def cart

  end

  def add_product_to_wish_list
    current_user.favourites_list = FavouritesList.create(:user => current_user) unless current_user.favourites_list.present?

    current_user.favourites_list.save_product_row @product
    current_user.save!

    redirect_to cart_path
  end

  private
  def set_product
    @product = Product.friendly.find(params[:product_id])
    @product.update_attribute(:views, @product.views + 1)
  end

end
