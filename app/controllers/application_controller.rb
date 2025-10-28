class ApplicationController < ActionController::Base
  include Pundit::Authorization
  set_current_tenant_by_subdomain(:workspace, :subdomain)
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
