class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def overlapping_approved_trips(trip)
    Trip.where("start BETWEEN :trip_start AND :trip_end OR finish BETWEEN :trip_start AND :trip_end OR start <= :trip_start AND finish >= :trip_end", {trip_start: trip.start, trip_end: trip.finish})
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not allowed to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
