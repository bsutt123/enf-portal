class TripsController < ApplicationController

  def index
    @session = Session.find(params[:session])
    @counselor = current_user.counselor
    @session_counselor = SessionCounselor.find_by(session: @session, counselor: @counselor)
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
    @session = Session.find(params[:session])
    @collection = [@session.cabins, @session.enf_classes].flatten
    @trip_group_types = [Cabin, EnfClass]
  end

  def create
    trip_group_type = params[:trip][:trip_group_type].constantize
    trip_group_id = params[:trip][:trip_group_id]

    session = trip_group_type.find(trip_group_id)
    session_counselor = SessionCounselor.find_by(session: session, counselor: current_user.counselor)

    trip_group_type.trips.create(trip_params)
    binding.pry
    if @trip.save
      flash[:notice] = "You successfully saved the Trip."
      redirect_to @trip
    else
      flash[:alert] = "There was a problem saving your Trip"
      redirect_to root_path
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
    params.require(:trip).permit(:description, :destination, :trip_group_id)
  end

end
