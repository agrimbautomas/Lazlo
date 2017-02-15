class UsersController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!
  before_action :set_product, only: [:add_product_to_wish_list]

  def cart
    @user_products = Product.all
  end

  def add_product_to_wish_list
    current_user.wish_list = WishList.create unless current_user.wish_list.present?
    byebug
    current_user.wish_list.products << @product
    current_user.wish_list.save!
  end

  private
  def set_product
    @product = Product.friendly.find(params[:product_id])
    @product.update_attribute(:views, @product.views + 1)
  end

end
