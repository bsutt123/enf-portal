module CounselorsHelper
  def setup_counselor(counselor)
    counselor.user ||= User.new
    counselor
  end

end
