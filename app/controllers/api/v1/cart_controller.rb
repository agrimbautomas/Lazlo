class Api::V1::CartController < Api::V1::ApiController
  version 1

  before_action :set_product, :set_user

  def remove_product
    byebug
    expose [:response => 'papinnnn']
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end


end