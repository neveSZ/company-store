class OrderMessagesController < ApplicationController
  before_action :authenticate_collaborator!

  def create
    @order_message = OrderMessage.new(order_message_params)
    @order_message.collaborator = current_collaborator
    if @order_message.save
      redirect_to @order_message.order
    else
      redirect_to @order_message.order, alert: 'A mensagem não pode estar vazia'
    end
  end

  private def order_message_params
    params.require(:order_message).permit(:text, :order_id)
  end
end
