class UserMailer < ApplicationMailer
  default from: 'website@macain.com.ar'

  def contact_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: 'tomas@macain.com.ar', subject: 'Welcome to My Awesome Site')
  end

  def contact_email

    @url  = 'http://example.com/login'
    mail(to: 'tomas@macain.com.ar', subject: 'Welcome to My Awesome Site')
  end
end
