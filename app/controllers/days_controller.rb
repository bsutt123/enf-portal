class DaysController < ApplicationController
  def show
    @day = Day.find(params[:id])
    date = @day.date
    @day_trips = day_trips_off_campus(date)
    @multi_day_trip_ends = multi_day_ends(date)
    @multi_day_trip_starts = multi_day_starts(date)
    @multi_day_all_day = multi_day_all_day(date)
  end

  def edit
  end

  def new

  end

  def create

  end

  def update

  end

  def destroy

  end

end
