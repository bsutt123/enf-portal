class DaysController < ApplicationController
  def show
    @day = Day.find(params[:id])
    @trip_starts = @day.trip_starts
    @trip_ends = @day.trip_ends
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
