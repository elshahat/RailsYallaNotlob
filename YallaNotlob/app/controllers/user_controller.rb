class UserController < Devise::RegistrationsController
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :gender, :image)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :username, :gender, :image)
  end
end
