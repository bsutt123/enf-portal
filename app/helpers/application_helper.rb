module ApplicationHelper
  def trip_group_name(trip)
    if trip.class == EnfClass
      "#{trip.name}"
    else
      "#{trip.number}"
    end
  end
end
