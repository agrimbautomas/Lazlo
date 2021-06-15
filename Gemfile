source 'https://rubygems.org'

gem 'rails', '5.1.6'


# Active admin, url: https://github.com/activeadmin/activeadmin
gem 'activeadmin', '1.3.0'

# url: https://github.com/vigetlabs/active_material
gem 'active_material', github: 'vigetlabs/active_material'

# url: https://github.com/ball-hayden/responsive_active_admin
gem 'responsive_active_admin'

# url: https://github.com/activeadmin-plugins/active_admin_datetimepicker
#gem 'active_admin_datetimepicker'

gem 'bcrypt_pbkdf'
gem 'ed25519'

# Mailchimp integration, url: https://github.com/amro/gibbon
gem 'gibbon'

# For admin authorizations, url: https://github.com/CanCanCommunity/cancancan
gem 'cancan'
gem 'coffee-rails'
gem 'config'

gem 'devise'
gem 'devise-encryptable'
gem 'devise-i18n'

# Auto schema in models, url: https://github.com/ctran/annotate_models
gem 'annotate'

# Ruby on Rails unobtrusive scripting adapter for jQuery https://github.com/rails/jquery-ujs
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'

gem 'rails_config'

gem 'mysql2'
gem 'omniauth-facebook'

gem 'paperclip', '~> 5.0.0'
gem 'rails-i18n'


# For User roles, url: https://github.com/RolifyCommunity/rolify
gem 'rolify'

# url: https://github.com/rails-api/active_model_serializers
gem 'active_model_serializers', '~> 0.10.0'

gem 'simple_form'

# MercadoPago https://github.com/mercadopago/sdk-ruby
gem 'mercadopago-sdk'

gem 'friendly_id', '~> 5.1.0'
gem 'instagram'

gem 'letsencrypt_plugin'

gem 'actionpack'
gem 'railties', '~> 5.0', '>= 5.0.0.1'

gem 'sass-rails', '~> 5.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'sqlite3'

gem 'turbolinks'

gem 'uglifier', '>= 1.3.0'

gem 'puma', '~> 4.3', '>= 4.3.7'
gem 'sitemap_generator'
gem 'paranoia', '~> 2.2'

# For the js runtime
gem 'therubyracer', platforms: :ruby

# Unobtrusive and flexible spam protection for Rails apps
gem 'invisible_captcha'

group :development, :test do
	# Replaces the standard Rails error page with a much better page
	gem 'better_errors'
	gem 'binding_of_caller'
	gem 'byebug'

	gem 'factory_bot_rails'
	gem 'json_matchers'

	gem 'rspec-collection_matchers'
	gem 'rspec-mocks'
	gem 'rspec-rails'
	gem 'rubycritic', require: false
	gem 'shoulda-matchers', '~> 3.1'
	gem 'simplecov'

	gem 'rails-controller-testing'

	# Pry console, url: https://github.com/rweng/pry-rails
	gem 'pry'
	gem 'pry-rails'

	gem 'rubocop', '~> 0.56.0', require: false
	gem 'rubocop-rspec'

end

group :development do
	gem 'capistrano', '~> 3.9'
	gem 'capistrano-rails', '~> 1.1'
	gem 'capistrano-rvm'
	gem 'capistrano3-puma', github: 'seuros/capistrano-puma', require: false
	gem 'capistrano-bundler'

	# Spring speeds up development by keeping your application running in the bg
	gem 'spring'
	gem 'spring-watcher-listen', '~> 2.0.0'

	# Access an IRB console on exception pages or by using <%= console %>
	gem 'web-console', '>= 3.3.0'
end

group :production do
	gem 'sentry-raven'
end
