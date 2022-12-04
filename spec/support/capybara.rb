RSpec.configure do |config|
  config.include Capybara::RSpecMatchers, type: :request
end

Capybara.default_driver = :selenium_chrome_headless