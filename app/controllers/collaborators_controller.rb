class CollaboratorsController < ApplicationController
  before_action :authenticate_collaborator!

  def show
    if current_collaborator.company == Collaborator.find(params[:id]).company
      @collaborator = Collaborator.find(params[:id])
      @products = Product.joins(:collaborator).where(status: 0, collaborators: { company: @collaborator.company })
    else
      redirect_to root_path, alert: 'Esse colaborador não é da sua empresa'
    end
  end
  
end
