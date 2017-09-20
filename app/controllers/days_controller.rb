class DaysController < ApplicationController
  def show
    @day = Day.find(params[:id])
    date = @day.date
    @day_trips = Trip.day_trips_off_campus(date)
    @multi_day_trip_ends = Trip.multi_day_ends(date)
    @multi_day_trip_starts = Trip.multi_day_starts(date)
    @multi_day_all_day = Trip.multi_day_all_day(date)
    overlapping_lunch = Trip.overlaps_lunch_on(date)
    s_vans = @day.session.session_vans
    used_s_vans = TripVan.where(trip_id: overlapping_lunch.pluck(:id)).pluck(:session_van_id)
    @available_session_vans = s_vans.where.not(id: used_s_vans)
  end

  def today
    #@day = Day.find_by(date: Date.today)
    @day = Trip.first.start_day


  end


end
