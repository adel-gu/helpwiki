class WorkspacesController < ApplicationController
  before_action :redirect_if_workspace_exists

  # GET /workspaces/new
  def new
    @workspace = Workspace.new
  end

  # POST /workspaces or /workspaces.json
  def create
    @workspace = Workspace.new(workspace_params)
    current_user.update(workspace: @workspace, role: 4)

    respond_to do |format|
      if @workspace.save
        format.html { redirect_to app_root_path(@workspace.subdomain), notice: "Workspace was successfully created." }
        format.json { render :show, status: :created, location: @workspace }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def workspace_params
      params.expect(workspace: [ :name, :subdomain ])
    end

    def redirect_if_workspace_exists
      return unless current_user&.workspace.present?

      redirect_to app_root_path(current_user.workspace.subdomain)
    end
end
