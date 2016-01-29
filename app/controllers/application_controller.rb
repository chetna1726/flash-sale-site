class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :authenticate

  private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    helper_method :current_user

    def authenticate
      redirect_to users_path unless current_user
    end
end
