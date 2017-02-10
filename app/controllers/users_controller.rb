class UsersController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!

  def cart
    @user_products = Product.all
  end



end
