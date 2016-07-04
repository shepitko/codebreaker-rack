require 'capybara/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  Capybara.configure do |config|
    config.run_server = false
    config.default_driver = :selenium
    config.app_host = 'http://localhost:9292' # change url
  end
end