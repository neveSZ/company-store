class ProductsController < ApplicationController
  before_action :authenticate_collaborator!

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    @product.collaborator = current_collaborator
    puts(@product.images)
    if @product.save
      flash.now[:notice] = 'Anuncio criado com sucesso'
      render :show
    else
      @categories = Category.all
      render :new
    end
  end

  def show
    if current_collaborator.company != Product.find(params[:id]).collaborator.company
      redirect_to root_path, flash: { alert: 'Produto indisponível' }
    else
      @product = Product.find(params[:id])
    end
  end

  private def product_params
    params.require(:product).permit(:name, :category_id, :description, :value, :messages_id, { images: [] })
  end
end
