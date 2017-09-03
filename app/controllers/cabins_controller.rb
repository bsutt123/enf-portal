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

    if @cabin.save
      flash[:notice] = "You successfully saved the cabin"
      redirect_to @cabin
    else
      flash[:alert] = "There was a problem saving the cabin"
      redirect_to root_path
    end
  end

  def update
    @cabin = Cabin.find(params[:id])
    @cabin.assign_attributes(cabin_params)

    if @cabin.save
      flash[:notice] = "You successfully edited the cabin."
    else
      flash[:alert] = "There was a problem saving your cabin"
    end
    redirect_to @cabin
  end

  def destroy
    @cabin = Cabin.find(params[:id])

    if @cabin.destroy
      flash[:notice] = "Cabin was successfully deleted."
    else
      flash[:alert] =  "There was a problem deleting your cabin"
    end
    redirect_to root_path
  end

  private

  def cabin_params
    params.require(:cabin).permit(:number, :session_id)
  end

end
