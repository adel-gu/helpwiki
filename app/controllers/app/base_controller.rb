class App::BaseController < ApplicationController
  include Pundit::Authorization
  set_current_tenant_through_filter

  before_action :authenticate_user!, :set_tenant, :ensure_user_in_workspace!

  layout "app"

  private

    def set_tenant
      subdomain = params[:subdomain]

      # Assume user has no workspace if the subdomain is missing
      unless subdomain.present?
        redirect_to new_workspace_path, alert: "Workspace not specified."
        return
      end

      workspace = Workspace.find_by(subdomain: subdomain)

      # If no workspace found redirect to the new workspace view
      unless workspace
        redirect_to new_workspace_path, alert: "Workspace not found."
        return
      end

      set_current_tenant(workspace)
    end

    def ensure_user_in_workspace!
      # If user doesn’t belong to any workspace, redirect to create one
      unless current_user.workspace
        redirect_to new_workspace_path, alert: "You need to create or join a workspace first."
        return
      end

      # If user tries to access a different workspace, kick them back
      if current_user.workspace_id != current_tenant.id
        redirect_to app_root_path, alert: "You are not authorized for this workspace."
      end
    end

    def default_url_options
      current_tenant ? { subdomain: current_tenant.subdomain } : {}
    end
end
