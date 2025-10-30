class App::BaseController < ApplicationController
  include Pundit::Authorization
  set_current_tenant_by_subdomain(:workspace, :subdomain)

  before_action :authenticate_user!

  layout "app"
end
