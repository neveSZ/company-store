class ProductMessagesController < ApplicationController
  before_action :authenticate_collaborator!

  def create
    @product_message = ProductMessage.new(product_message_params)
    @product_message.collaborator = current_collaborator
    if @product_message.save
      redirect_to @product_message.product
    else
      redirect_to @product_message.product, alert: 'A mensagem não pode estar vazia'
    end
  end

  private def product_message_params
    params.require(:product_message).permit(:text, :product_id)
  end
end
