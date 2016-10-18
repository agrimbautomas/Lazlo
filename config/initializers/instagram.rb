require "instagram"


Instagram.configure do |config|
  config.client_id = '4380181e65cc48d08533291306926855'
  config.client_secret =  '9d20f6a1e28849ffbc250b977ceaa294'

  # For secured endpoints only
  #config.client_ips = '<Comma separated list of IPs>'
end
