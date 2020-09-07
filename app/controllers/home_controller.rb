class HomeController < ApplicationController
  before_action :authenticate_collaborator!
  def index
    @categories = Category.all
    @collaborator = current_collaborator
  end
end
