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

end
