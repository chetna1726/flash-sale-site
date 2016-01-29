class OrdersController < ApplicationController

  def create
    @order = Order.new(user_id: current_user.id, deal_id: params[:deal_id])
    if @order.save
      flash[:notice] = 'Order has been successfully placed.'
    else
      flash[:error] = @order.errors.full_messages.join('<br>')
    end
    redirect_to live_deals_path
  end
end