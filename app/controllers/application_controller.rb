class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    if resource.workspace
      app_root_path(resource.workspace.subdomain)
    else
      new_workspace_path
    end
  end

  def after_accept_path_for(resource)
    app_root_path(resource.workspace.subdomain)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :full_name ])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [ :full_name ])
  end
end
