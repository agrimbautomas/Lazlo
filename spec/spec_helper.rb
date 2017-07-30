#Coverage
require 'simplecov'
SimpleCov.start do
  coverage_dir 'test_output/coverage/'
  add_filter 'app/admin'
end

#Testing
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'paperclip/matchers'
require 'rspec/collection_matchers'
require 'helpers/controller_helpers'

RSpec.configure do |config|
  config.include RocketPants::TestHelper, type: :controller
  config.include RocketPants::RSpecMatchers, type: :controller
  config.include Paperclip::Shoulda::Matchers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include ControllerHelpers, :type => :controller

  config.expect_with :rspec do |expectations|
	 expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
	 mocks.verify_partial_doubles = true
  end


  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

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

end

