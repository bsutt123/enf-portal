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

end
