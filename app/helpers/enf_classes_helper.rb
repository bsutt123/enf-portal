module EnfClassesHelper
  def session_camper_proc
    return Proc.new {|x| x.camper.name}
  end

  def session_counselor_proc
    return Proc.new {|x| x.counselor.name}
  end

end
