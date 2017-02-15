class UsersController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!
  before_action :set_product, only: [:add_product_to_wish_list]

  def cart
    #@user_products = Product.all

    @user_products_list = current_user.products_list
  end

  def add_product_to_wish_list
    current_user.products_list = ProductsList.create(:user => current_user) unless current_user.products_list.present?

    product_row = ProductRow.create(:product => @product)
    current_user.products_list.save_product_row product_row
    current_user.save!

    redirect_to cart_path
  end

  private
  def set_product
    @product = Product.friendly.find(params[:product_id])
    @product.update_attribute(:views, @product.views + 1)
  end

end
