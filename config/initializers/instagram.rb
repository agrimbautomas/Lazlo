require "instagram"

Instagram.configure do |config|
  config.client_id = Rails.application.secrets[:instagram_client_id]
  config.client_secret =  Rails.application.secrets[:instagram_client_secret]

  # For secured endpoints only
  #config.client_ips = '<Comma separated list of IPs>'
end

INSTRAGRAM_ACCESS_TOKEN = Rails.application.secrets[:instagram_access_token]