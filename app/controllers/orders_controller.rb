class OrdersController < ApplicationController
  before_action :authenticate_collaborator!

  def create
    @order = Order.new(order_params)
    @order.collaborator = current_collaborator

    if current_collaborator.active?
      if @order.save
        @order.product.set_negotiation
        flash.now[:notice] = 'Pedido realizado com sucesso'
        render :show
      else
        redirect_to root_path, notice: 'Ocorreu um erro ao realizar seu pedido'
      end
    else
      redirect_to edit_collaborator_registration_path, notice: 'Para fazer um pedido complete seu cadastro'
    end
  end

  def index
    @orders = if params[:seller] == 'true'
                Order.joins(:product).where(products: { collaborator: current_collaborator })
              else
                Order.where(collaborator: current_collaborator)
              end
  end

  private def order_params
    params.permit(:product_id)
  end
end
