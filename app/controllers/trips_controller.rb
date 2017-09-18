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
    @van_capacity = Van.where(id: @trip.session_vans.pluck(:van_id)).pluck(:capacity).reduce(:+)
    @total_people = @trip.session_campers.count+@trip.session_counselors.count
    @num_drivers = Counselor.where(id: @trip.session_counselors.pluck(:counselor_id)).where(driver: true).count
    @num_lifeguards = Counselor.where(id: @trip.session_counselors.pluck(:counselor_id)).where(lifeguard: true).count
    @num_wfas = Counselor.where(id: @trip.session_counselors.pluck(:counselor_id)).where(wfa: true).count
  end

  def edit
    @trip = Trip.find(params[:id])
    @session = @trip.session
    overlapping_trips = Trip.overlapping_approved_trips(@trip)
    s_van_ids = @session.session_van_ids
    used_vans = []
    overlapping_trips.each do |approved_trip|
      approved_trip.session_van_ids.each do |s_van_id|
        used_vans << s_van_id
      end
    end
    s_van_ids -= used_vans
    @possible_vans = s_van_ids.map do |s_van_id|
      @session.session_vans.find(s_van_id)
    end
    @trip.session_vans.each do |s_van|
      @possible_vans << s_van
    end
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

    @trip.start_day = Day.find_by(date: @trip.start.to_date)
    @trip.end_day = Day.find_by(date: @trip.finish.to_date)

    if @trip.start.to_date == @trip.finish.to_date
      @trip.day_trip = true
    end
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

    @trip.start_day = Day.find_by(date: @trip.start.to_date)
    @trip.end_day = Day.find_by(date: @trip.finish.to_date)

    if @trip.start.to_date == @trip.finish.to_date
      @trip.day_trip = true
    end
    if @trip.save
      if current_user.admin? || current_user.program_assistant?
        flash[:notice] = "you successfully approved the trip"
      else
        flash[:notice] = "you succesfully saved the edits to your trip"
      end
      detonate_trip_campers(@trip)
      detonate_trip_counselors(@trip)
      create_trip_campers(params[:trip][:session_camper_ids], @trip)
      create_trip_counselors(params[:trip][:session_counselor_ids], @trip)

      if @trip.approved
        detonate_trip_vans(@trip)
        create_trip_vans(params[:trip][:session_van_ids], @trip)
      end
    else
      flash[:notice] = "There was a problem saving the changes to the trip"
    end
    redirect_to @trip
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
                                :start,
                                :finish,
                                :requires_van,
                                :requires_lifeguard,
                                :requires_wfa,
                                :approved
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

  def create_trip_vans(s_van_ids, trip)
    s_van_ids.each do |s_van_id|
      if s_van_id != ""
        TripVan.create(session_van: SessionVan.find(s_van_id), trip: trip)
      end
    end
  end

  def detonate_trip_vans(trip)
    trip_vans = trip.trip_vans
    trip_vans.each do |trip_van|
      trip_van.destroy
    end
  end

  def create_trip_campers(array, trip)
    array.each do |s_camper_id|
      if s_camper_id != ""
        TripCamper.create(session_camper: SessionCamper.find(s_camper_id), trip: trip)
      end
    end
  end

  def create_trip_counselors(array, trip)
    array.each do |s_counselor_id|
      if s_counselor_id != ""
        TripCounselor.create(session_counselor: SessionCounselor.find(s_counselor_id), trip: trip)
      end
    end
  end

  def detonate_trip_campers(trip)
    trip_campers = trip.trip_campers
    trip_campers.each do |trip_camper|
      trip_camper.destroy
    end

  end

  def detonate_trip_counselors(trip)
    trip_counselors = trip.trip_counselors
    trip_counselors.each do |trip_counselor|
      trip_counselor.destroy
    end
  end



end
