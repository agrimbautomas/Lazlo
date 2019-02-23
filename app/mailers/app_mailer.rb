class AppMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

  RECEIVERS = Settings.admin.emails
  URL = Settings.urls.base

  def mail_images
	 {
		  :logo => asset_absolute_path('mailer/lazlo-logo-black.png'),
		  :facebook => asset_absolute_path('mailer/facebook-lazlo.png'),
		  :instagram => asset_absolute_path('mailer/instagram-lazlo.png'),
		  :pinterest => asset_absolute_path('mailer/pinterest-lazlo.png'),
		  :header => asset_absolute_path('mailer/email-header.jpg')
	 }
  end

  private
  def asset_absolute_path asset_name
	 ActionController::Base.helpers.asset_path(asset_name)
  end

end