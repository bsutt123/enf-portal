module TripsHelper
  def collection_proc
    return Proc.new do |ele|
      if ele.class == EnfClass
        "Class: #{ele.name}"
      else
        "Cabin: #{ele.number}"
      end
    end
  end

  def delete_trip_access(trip)
    current_user == trip.session_counselor.counselor.user || current_user.admin? || current_user.program_assistant?
  end

  def wday_to_day(num)
    case num
    when 0
      "Sun"
    when 1
      "Mon"
    when 2
      "Tues"
    when 3
      "Wed"
    when 4
      "Thurs"
    when 5
      "Fri"
    when 6
      "Sat"
    else
      "Bad Input"
    end
  end

end
