class App::BaseController < ApplicationController
  include Pundit::Authorization
  set_current_tenant_through_filter

  before_action :authenticate_user!, :set_tenant, :ensure_user_in_workspace!

  layout "app"

  private

    def set_tenant
      subdomain = params[:subdomain]
      workspace = Workspace.find_by!(subdomain: subdomain)
      set_current_tenant(workspace)
    end

    def ensure_user_in_workspace!
      unless current_user.workspace_id == current_tenant.id
        redirect_to app_root_path(current_user.workspace.subdomain), alert: "Access denied"
      end
    end
end
