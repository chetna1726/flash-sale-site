class UsersController < ApplicationController

  before_action :authenticate_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate, :authenticate_admin, only: :index


  def index
    @users = User.all.order(:name)
    flash[:error] = @users.empty? ? 'No records to display!' : nil
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'user has been successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'user has been successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = 'user has been successfully deleted.'
    else
      flash[:error] = @user.errors.full_messages.join('<br>')
    end
    redirect_to users_path
  end

  private

    def set_user
      @user = User.find_by(id: params[:id])
      redirect_to users_path, error: 'user does not exist!' unless @user
    end

    def user_params
      params.require(:user).permit(:name)
    end
end