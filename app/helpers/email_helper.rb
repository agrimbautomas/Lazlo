module EmailHelper
  RECEIVERS = Settings.admin.emails
  URL = Settings.urls.base

  def resource_domain
	 Settings.urls.base_strip
  end

end
