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

  def add_camper
    @cabin = Cabin.find(params[:id])
    @session = @cabin.session
    @camper = Camper.find(params[:camper_id])
  end


  def create
    @cabin = Cabin.new(cabin_params)
    @cabin.assign_attributes(identifier: "Cabin #{@cabin.number} #{@cabin.session[:identifier]}" )
    if @cabin.save
      flash[:notice] = "You successfully saved the cabin"
      redirect_to [@cabin.session, @cabin]
    else
      flash[:alert] = "There was a problem saving the cabin"
      redirect_to root_path
    end
  end

  def update
    @cabin = Cabin.find(params[:id])
    @cabin.assign_attributes(cabin_params)

    camper_ids = params[:cabin][:camper_ids]
    detonate_session_campers(@cabin)
    camper_ids.each do |camper_id|
      if camper_id != ""
        SessionCamper.create(cabin: @cabin, session: @cabin.session, camper: Camper.find(camper_id))
      end
    end
    if @cabin.save
      flash[:notice] = "You successfully edited the cabin."
    else
      flash[:alert] = "There was a problem saving your cabin"
    end
    redirect_to [@cabin.session, @cabin]
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

  def detonate_session_campers(cabin)
    session_campers = cabin.session_campers
    session_campers.each do |camper|
      camper.destroy
    end
  end


end
