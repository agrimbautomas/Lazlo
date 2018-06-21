class AppMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

  RECEIVERS = Settings.admin.emails
  URL = Settings.urls.base

  def mail_images
	 {
		  :logo => asset_absolute_path('logos/lazlo-icon-40.png'),
		  :background => asset_absolute_path('logos/lazlo-icon-100.png')
	 }
  end

  private
  def asset_absolute_path asset_name
	 protocol = Rails.env.production? ? 'https:' : 'http:'
	 protocol + ActionController::Base.helpers.asset_path(asset_name)
  end

end