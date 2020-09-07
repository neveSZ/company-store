class HomeController < ApplicationController
  before_action :authenticate_collaborator!
  def index
    @categories = Category.all
    @collaborator = current_collaborator
    @products = Product.joins(:collaborator).where(status: 0, collaborators: { company: @collaborator.company })
  end
end
