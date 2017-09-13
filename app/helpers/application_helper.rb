module ApplicationHelper
  def trip_group_name(trip)
    if trip.class == EnfClass
      "#{trip.name}"
    else
      "#{trip.number}"
    end
  end

  def session_date_grabber(session, date)
    session.days.where(date: date).first
  end
end
