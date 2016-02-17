class UserMailer < ApplicationMailer
  default from: 'website@macain.com.ar'

  def contact_email params
    puts params.inspect
    @name = params[:name]
    @tel = params[:tel]
    @email = params[:email]
    @message = params[:message]
    @url  = 'http://macain.com.ar/'
    mail(to: 'tomas@macain.com.ar', subject: 'Siranushen Alert :) - Message from: ' + @name)
  end

  def simple_email
    @url  = 'http://macain.com.ar/'
    mail(to: 'tomas@macain.com.ar', subject: 'Siranushen Alert :) - Message from: Test')
  end
end
