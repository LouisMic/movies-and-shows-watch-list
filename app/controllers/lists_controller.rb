class ListsController < ApplicationController
  def new
    @list = List.new
  end

  def create
    @list = List.create(list_params)
    @list.save
    redirect_to lists_path()
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:name, :image_url)
  end
end
