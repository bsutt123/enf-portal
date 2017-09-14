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

  def session_camper_proc
    return Proc.new {|x| x.camper.name}
  end

  def session_counselor_proc
    return Proc.new {|x| x.counselor.name}
  end

  def van_proc
    return Proc.new {|x| x.van.number}
  end


  def overlapping_approved_trips(trip)
    Trip.where("start BETWEEN :trip_start AND :trip_end OR finish BETWEEN :trip_start AND :trip_end OR start <= :trip_start AND finish >= :trip_end", {trip_start: trip.start, trip_end: trip.finish}).where.not(trip[:id]).where(approved: true)
  end

  def format_datetime(time)
    time.strftime("%a %b %e at %k:%M")
  end

  def format_datetime_time(time)

  end
end
