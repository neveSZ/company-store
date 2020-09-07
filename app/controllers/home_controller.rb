class HomeController < ApplicationController
  before_action :authenticate_collaborator!
  def index
    @categories = Category.all
    @collaborator = current_collaborator
    @products = Product.joins(:collaborator).where(status: 0, collaborators: { company: @collaborator.company })
  end

  def search
    @collaborator = current_collaborator
    @products = Product.joins(:collaborator).where(status: 0, collaborators: { company: @collaborator.company })
                       .joins(:category).where('products.name LIKE :search  OR  products.description LIKE :search OR categories.name LIKE :search', search: "%#{params[:product_search]}%")

    @categories = Category.all
    render :index
  end
end
