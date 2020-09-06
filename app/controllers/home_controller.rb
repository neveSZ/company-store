class HomeController < ApplicationController
  before_action :authenticate_collaborator! # , authenticate_company!
  def index
    @categories = Category.all
    @collaborator = current_collaborator
  end
end
