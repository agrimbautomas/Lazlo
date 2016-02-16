class HomeController < ApplicationController
  def index
    UserMailer.contact_email.deliver_now
  end

  def show
  end
end
