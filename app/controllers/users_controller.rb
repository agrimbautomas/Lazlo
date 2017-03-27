class UsersController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!

  def cart

  end


end
