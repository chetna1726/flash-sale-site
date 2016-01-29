class DealsController < ApplicationController
  before_action :set_deal, only: [:show, :edit, :update, :destroy]

  def index
    @deals = Deal.all.order(:title)
    flash[:error] = @deals.empty? ? 'No records to display!' : nil
  end

  def new
    @deal = Deal.new
  end

  def create
    @deal = Deal.new(deal_params)
    if @deal.save
      redirect_to deals_path, notice: 'deal has been successfully created.'
    else
      flash[:error] = @deal.errors.messages[:base]
      render :new
    end
  end

  def update
    if @deal.update(deal_params)
      redirect_to deals_path, notice: 'deal has been successfully updated.'
    else
      flash[:error] = @deal.errors.messages[:base]
      render :edit
    end
  end

  def destroy
    if @deal.destroy
      flash[:notice] = 'deal has been successfully deleted.'
    else
      flash[:error] = @deal.errors.full_messages.join('<br>')
    end
    redirect_to deals_path
  end

  def live
    @deal = Deal.find_by(live: true)
    flash[:error] = 'No deal for today!' unless @deal
  end

  private

    def set_deal
      @deal = Deal.find_by(id: params[:id])
      redirect_to deals_path, error: 'deal does not exist!' unless @deal
    end

    def deal_params
      params.require(:deal).permit(:title, :description, :price, :discounted_price, :quantity, :publish_date, :publishable, :live)
    end
end