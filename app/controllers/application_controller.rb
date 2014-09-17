class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :title, :email, :password, :password_confirmation) }
  end

  protected

  def check_if_admin
    if signed_in?
      unless current_user.admin?
        redirect_to root_url
        flash[:error] = "You don't have enough permission to  Access this resource!"
      end
    else
      flash[:error] = "Please sign in!"
      redirect_to user_session_path
    end
  end

end
