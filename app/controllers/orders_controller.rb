class OrdersController < ApplicationController
  before_action :authenticate_collaborator!

  def create
    @order = Order.new(order_params)
    @order.collaborator = current_collaborator

    if @order.save
      flash.now[:notice] = 'Pedido realizado com sucesso'
      render :show
    else
      redirect_to root_path
    end
  end

  private def order_params
    params.permit(:product_id)
  end
end
