class TripsController < ApplicationController

  def index
    @session = Session.find(params[:session])
    @session_length = (@session.finish-@session.start).to_i
    @counselor = current_user.counselor
    @session_counselor = SessionCounselor.find_by(session: @session, counselor: @counselor)
    @trips = @session.trips
    @my_trips = @session_counselor.trips
    @days = @session.days
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
    trip_group = trip_group_type.find(trip_group_id)
    session = trip_group.session
    session_counselor = SessionCounselor.find_by(session: session, counselor: current_user.counselor)
    @trip = trip_group.trips.create(trip_params)
    @trip.session_counselor = session_counselor
    @trip.session = session

    if @trip.start != @trip.finish
      if @trip.start > @trip.finish
        flash[:alert] = "You set the start date to be after the end date!"
        redirect_back
      end
      @trip.day_trip = false
    end

    if @trip.save
      flash[:notice] = "You successfully saved the Trip."
      add_trip_campers(trip_group, @trip)
      add_trip_counselors(trip_group, @trip)
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
    params.require(:trip).permit(
                                :description,
                                :destination,
                                :trip_group_id,
                                :trip_group_type,
                                :requires_food,
                                :requires_gear,
                                :start_day_id,
                                :end_day_id,
                                :start_period,
                                :end_period,
                                :requires_van,
                                :requires_lifegaurd,
                                :requires_wfa
                                )
  end

  def add_trip_campers(group, trip)
    group.session_campers.each do |s_camper|
      TripCamper.create(session_camper: s_camper, trip: trip)
    end
  end

  def add_trip_counselors(group, trip)
    group.session_counselors.each do |s_counselor|
      TripCounselor.create(session_counselor: s_counselor, trip: trip)
    end
  end



end
