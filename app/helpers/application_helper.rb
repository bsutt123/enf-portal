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

  def format_datetime(time)
    time.strftime("%a %b %e at %k:%M")
  end

  def format_datetime_time(time)
    time.strftime("%k:%M")
  end

  def format_period(period)
    case period
    when "one_and_two_mwf"
      "1 and 2 on MWF"
    when "one_and_two_tts"
      "1 and 2 on TTS"
    when "three_and_four_mwf"
      "3 and 4 on MWF"
    when "three_and_four_tts"
      "3 and 4 on TTS"
    when "one"
      "1"
    when "two"
      "2"
    when "three"
      "3"
    when "four"
      "4"
    when "twilight"
      "Twilight"
    else
      period
    end
  end

  def alternating_period?(enf_class)
    enf_class.one_and_two_mwf? || enf_class.period.one_and_two_tts? || enf_class.three_and_four_mwf? || enf_class.three_and_four_tts?
  end
  def format_underscores(string)
    string.split("_").join(" ")
  end


  def current_session
    current_session = Session.where("finish >= ?", Date.today).first
  end
end
