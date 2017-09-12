class AppMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  add_template_helper(EmailHelper)

  RECEIVERS = Settings.admin.emails
  URL = Settings.urls.base

  def mail_images
	 {
		  :logo => asset_absolute_path('logo-alomacain.png'),
		  :background => asset_absolute_path('fondo-colores.png')
	 }
  end

  private
  def asset_absolute_path asset_name
	 protocol = Rails.env.production? ? 'https:' : 'http:'
	 protocol + ActionController::Base.helpers.asset_path(asset_name)
  end

end