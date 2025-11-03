RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.before(:each, type: :request) do
    Rails.application.reload_routes_unless_loaded
  end
end
