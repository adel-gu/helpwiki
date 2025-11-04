class App::ProfilesController < App::BaseController
  before_action :set_user

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to edit_app_profile_path, notice: "Your profile has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.expect(user: [:full_name])
  end
end
