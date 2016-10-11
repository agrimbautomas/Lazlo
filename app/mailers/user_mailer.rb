class UserMailer < ApplicationMailer
  default from: 'website@macain.com.ar'

  def contact_email params
    @name = params[:name]
    @tel = params[:tel]
    @email = params[:email]
    @message = params[:message]
    @url  = 'http://macain.com.ar/'
    mail(to: 'alo@macain.com.ar, tomas@macain.com.ar', subject: 'Siranushen Alert :) - Message from: ' + @name)
  end

end
