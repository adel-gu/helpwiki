class App::UsersManagementController < App::BaseController
  before_action :set_user, only: %i[update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.invite!(
      { email: user_params[:email], role: user_params[:role], workspace: current_tenant },
      current_user # inviter
    )

    if @user.errors.empty?
      redirect_to app_users_management_index_path(current_tenant.subdomain), notice: "Invitation sent to #{@user.email}."
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH /app/users_management/:id
  def update
    if @user.update(user_params)
      redirect_to app_users_management_index_path, notice: "User role updated successfully."
    else
      redirect_to app_users_management_index_path, alert: "Failed to update user role."
    end
  end

  # DELETE /app/users_management/:id
  def destroy
    if @user.destroy
      redirect_to app_users_management_index_path, notice: "User removed successfully."
    else
      redirect_to app_users_management_index_path, alert: "Failed to remove user."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :role)
  end
end
