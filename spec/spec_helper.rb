#Coverage
require 'simplecov'
SimpleCov.start 'rails' do
  project_name 'Lazlo Web Site'
  coverage_dir 'test_output/coverage/'

  # Ignore default files, uncomment if modified
  add_filter 'app/admin'

  add_filter 'app/controllers/application_controller.rb'
  add_filter 'app/controllers/errors_controller.rb'
  add_filter 'app/controllers/omniauth_callbacks_controller.rb'

  add_filter 'app/helpers/application_helper.rb'

  add_filter 'app/models/ability.rb'

  add_filter 'app/mailers/application_mailer.rb'

  add_filter 'app/jobs/application_job.rb'

  add_filter 'app/interactors/background_job.rb'
  add_filter 'app/interactors/auto_upload_images.rb'

  add_filter 'bin'
  add_filter 'challenge'
  add_filter 'config'
  add_filter 'db'
  add_filter 'key'
  add_filter 'lib'
  add_filter 'log'
  add_filter 'public'
  add_filter 'reports'
  add_filter 'site-images'
  add_filter 'spec'
  add_filter 'vendor'
  add_filter 'test_output'


  add_group 'Models', '/app/models'
  add_group 'Controllers', '/app/controllers'
  add_group 'Interactors', '/app/interactors'
  add_group 'Serializers', '/app/serializers'
  add_group 'Services', '/app/services'
end

#Testing
require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'paperclip/matchers'
require 'rspec/collection_matchers'
require 'json_matchers/rspec'
require 'support/factory_bot'
require 'support/mercado_pago_helper'
require 'support/paranoia_examples'

RSpec.configure do |config|
  config.include Paperclip::Shoulda::Matchers
  config.include Rails.application.routes.url_helpers

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view

  config.expect_with :rspec do |expectations|
	 expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
	 mocks.verify_partial_doubles = true
  end


  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.color = true

end

