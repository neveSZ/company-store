class ProductsController < ApplicationController
  before_action :authenticate_collaborator!

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    @product.collaborator = current_collaborator
    if @product.save
      redirect_to @product, notice: 'Anuncio criado com sucesso'
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

  def index
    @products = Product.where(collaborator: current_collaborator)
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      @product.status = product_params[:status]
      redirect_to @product
    else
      @products = Product.where(collaborator: current_collaborator)
      render :index
    end
  end

  private def product_params
    params.require(:product).permit(:name, :category_id, :description, :value, :messages_id, :status, { images: [] })
  end
end
