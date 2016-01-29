class SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    session[:user_id] = params[:user_id]
    redirect_to :back
  end

  def destroy
    reset_session
    redirect_to login_path, alert: 'You have been successfully logged out.'
  end
end
