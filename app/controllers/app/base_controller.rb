class App::BaseController < ApplicationController
  include Pundit::Authorization
  set_current_tenant_through_filter

  before_action :authenticate_user!, :set_tenant

  layout "app"

  private

    def set_tenant

    end

end
