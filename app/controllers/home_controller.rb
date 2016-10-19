class HomeController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
  end

  def contact_email
    UserMailer.contact_email(contact_params).deliver_now
    redirect_to root_path
  end


  def cotizador
    @marvels = Marvel.all.order(:name)
  end

  private

  def contact_params
    params.permit(:name, :tel, :email, :message)
  end

end
