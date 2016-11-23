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


  def contact_email
    UserMailer.contact_email(contact_params).deliver_now
    flash[:notice] = 'Se envió el mensaje, en breve nos vamos a estar contactando. Gracias!'
    redirect_to root_path
  end

  private

  def contact_params
    params.permit(:macain_name, :macain_email, :macain_message)
  end

  def set_og_tags title=nil, description=nil, image=nil
    @og_title = title + '|| Macain'
    @og_description = description
    @og_image = image
  end

  def resource_absolute_path asset_name
    ActionController::Base.helpers.asset_path(asset_name)
  end

end
