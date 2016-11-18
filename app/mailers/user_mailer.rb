class UserMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views


  def confirmation_instructions(record, token, opts={})
    @images = {
        :logo => asset_absolute_path('logo-macain-300.png'),
        :background => asset_absolute_path('fondo-colores.png'),
        :account_icon => asset_absolute_path('new-account-icon.png'),
    }
    puts super(record, token, opts={})
  end


  def reset_password_instructions(record, token, opts={})
    @images = {
        :logo => asset_absolute_path('logo-macain-300.png'),
        :background => asset_absolute_path('fondo-colores.png'),
        :lock => asset_absolute_path('lock-icon-macain.png'),
    }
    puts super(record, token, opts={})
  end

  def contact_email params
    @name = params[:macain_name]
    @email = params[:macain_email]
    @message = params[:macain_message]
    @url = 'http://macain.com.ar/'
    mail(to: 'alo@macain.com.ar, tomas@macain.com.ar', subject: 'Siranushen Alert :) - Message from: ' + @name)
  end

  private
  def asset_absolute_path asset_name
    'http:' + ActionController::Base.helpers.asset_path(asset_name)
  end

end