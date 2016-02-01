class AdminsController < ApplicationController

  before_action :authenticate_admin
  before_action :set_admin, only: [:show, :edit, :update, :destroy]


  def index
    @admins = Admin.all.order(:name)
    flash[:error] = @admins.empty? ? 'No records to display!' : nil
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to admins_path, notice: 'Admin has been successfully created.'
    else
      render :new
    end
  end

  def update
    if @admin.update(admin_params)
      redirect_to admins_path, notice: 'Admin has been successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      flash[:notice] = 'Admin has been successfully deleted.'
    else
      flash[:error] = @admin.errors.full_messages.join('<br>')
    end
    redirect_to admins_path
  end

  private

    def set_admin
      @admin = Admin.find_by(id: params[:id])
      redirect_to admins_path, error: 'Admin does not exist!' unless @admin
    end

    def admin_params
      params.require(:admin).permit(:name)
    end
end