class UsersController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!

  def cart

  end

  def profile

  end

end