class ListsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end
end
