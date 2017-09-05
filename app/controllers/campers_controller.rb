class CampersController < ApplicationController
  def index
    @campers = Camper.all
  end

  def show
    @camper = Camper.find(params[:id])
  end

  def edit
    @camper = Camper.find(params[:id])
  end

  def new
    @camper = Camper.new
  end

  def create
    @camper = Camper.new(camper_params)

    if @camper.save
      flash[:notice] = "The camper was successfully saved"
      redirect_to @camper
    else
      flash[:alert] = "There was a probleming saving the new camper."
      redirect_to campers_path
    end
  end

  def update
    @camper = Camper.find(params[:id])
    @camper.assign_attributes(camper_params)

    if @camper.save
      flash[:notice] = "The camper was succesfully edited"
    else
      flash[:alert] =  "There was a problem saving the edit"
    end
    redirect_to @camper
  end

  def destroy
    @camper = Camper.find(params[:id])

    if @camper.destroy
      flash[:notice] = "The Camper was succesfully deleted"
      redirect_to campers_path
    else
      flash[:alert] = "There was a problem deleting the camper"
      redirect_to @camper
    end
  end

  private

  def camper_params
    params.require(:camper).permit(:name)
  end

end
