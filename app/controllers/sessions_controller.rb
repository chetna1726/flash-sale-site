class SessionsController < ApplicationController

  skip_before_action :authenticate

  def create
    session[:admin_id] = params[:admin_id]
    session[:user_id] = params[:user_id]
    redirect_to :back
  end
end
