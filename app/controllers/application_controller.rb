class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def overlapping_approved_trips(trip)
    Trip.where("start BETWEEN :trip_start AND :trip_end OR finish BETWEEN :trip_start AND :trip_end OR start <= :trip_start AND finish >= :trip_end", {trip_start: trip.start, trip_end: trip.finish})
  end

  def day_trips_off_campus(date)
    time_line = (date..(date+1))
    Trip.where(start: time_line, approved: true, day_trip: true)
  end

  def multi_day_starts(date)
    time_line = (date..(date+1))
    Trip.where(approved:true).where(start: time_line, day_trip:false)
  end

  def multi_day_ends(date)
    time_line = (date..(date+1))
    Trip.where(approved: true).where(finish: time_line, day_trip:false)
  end

  def multi_day_all_day(date)
    date_hash = {start_date: date, finish_date: (date+1) }
    Trip.where(approved: true).where("start < :start_date AND finish > :finish_date",date_hash)
  end

  def current_session
    current_session = Session.where("finish >= ?", Date.today).first
  end


  private

  def user_not_authorized
    flash[:alert] = "You are not allowed to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
