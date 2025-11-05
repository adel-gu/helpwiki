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

  def security; end

  def update_password
    if @user.update_with_password(password_params)
      # Sign in the user again after password change
      bypass_sign_in(@user)
      redirect_to security_app_profile_path, notice: "Your password has been updated successfully."
    else
      render :security, status: :unprocessable_entity
    end
  end

  def notifications; end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.expect(user: [ :full_name ])
  end

  def password_params
    params.expect(user: [ :current_password, :password, :password_confirmation ])
  end
end
