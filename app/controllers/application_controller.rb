class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_filter :load_page_categories, :set_instagram

  def set_instagram
    @instagram_client = Instagram.client(:access_token => INSTRAGRAM_ACCESS_TOKEN)
  end

  def load_page_categories
    @page_categories = Category.all
  end



end
