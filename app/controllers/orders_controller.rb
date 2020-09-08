class OrdersController < ApplicationController
  before_action :authenticate_collaborator!

  def create
    @order = Order.new(params.permit(:product_id))
    @order.collaborator = current_collaborator

    if current_collaborator.active?
      if @order.save
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

  def show
    @order = Order.find(params[:id])
  end

  def completed
    @order = Order.find(params[:id])
    @order.set_completed
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      @order.product.set_avaliable if order_params[:status] == 'canceled'
      redirect_to @order
    else
      render :completed
    end
  end

  private def order_params
    params.require(:order).permit(:value, :status)
  end
end
