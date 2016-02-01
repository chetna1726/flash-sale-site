class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :authenticate

  private

    def current_user
      @current_user ||= Admin.find_by(id: session[:admin_id]) || User.find_by(id: session[:user_id])
    end
    helper_method :current_user

    def authenticate
      redirect_to users_path unless current_user
    end

    def authenticate_admin
      redirect_to users_path unless current_user.is_a? Admin
    end
end
