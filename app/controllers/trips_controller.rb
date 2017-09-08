class TripsController < ApplicationController

  def index

    @session = Session.find(params[:session])
    @counselor = current_user.counselor
    @session_counselor = SessionCounselor.find_by(session: @session, counselor: @counselor)
    binding.pry
    @trips = @session_counselor.trips


  end

  def show
    @trip = Trip.find(params[:id])
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      flash[:notice] = "You successfully saved the Trip."
      redirect_to @trip
    else
      flash[:alert] = "There was a problem saving your Trip"
      redirect_to trips_path
    end
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.assign_attributes(trip_params)

  end

  def destroy

  end

  def enf_session
    @sessions = Session.all
  end


  private

  def trip_params
    params.require(:trip).permit(:description, :destination, :session_counselor, :trip_counselors, :trip_campers)
  end

end
