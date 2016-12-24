class AppMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

  private
  def asset_absolute_path asset_name
    'http:' + ActionController::Base.helpers.asset_path(asset_name)
  end

end