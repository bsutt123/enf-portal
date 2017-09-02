class CabinsController < ApplicationController
  def index
    @cabins = Cabin.all
  end

  def show
    @cabin = Cabin.find(params[:id])
  end

  def new
    @cabin = Cabin.new
  end

  def edit
    @cabin = Cabin.find(params[:id])
  end

  def create
    @cabin = Cabin.new(cabin_params)
    binding.pry

    if @cabin.save
      flash[:notice] = "You successfully saved the cabin"
      redirect_to @cabin
    else
      flash[:alert] = "There was a problem saving the cabin"
      redirect_to root_path
    end
  end

  def update

  end

  def destroy

  end

  private

  def cabin_params
    params.require(:cabin).permit(:number, :session_id)
  end

end
