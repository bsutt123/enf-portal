class SessionCounselorsController < ApplicationController
  def show
    @session_counselor = SessionCounselor.find(params[:id])
  end

  def edit
    @session_counselor = SessionCounselor.find(params[:id])
    @enf_classes = @session_counselor.session.enf_classes
  end

  def update
    @session_counselor = SessionCounselor.find(params[:id])
    @session_counselor.assign_attributes(session_counselor_params)
    enf_classes = params[:session_counselor][:instructors_attributes].values
    enf_classes.each do |class_hash|
      enf_class = EnfClass.find(class_hash[:enf_class_id].to_i)
      if enf_class.one_and_two_mwf? || enf_class.three_and_four_mwf?
        Instructor.where(enf_class: enf_class, session_counselor: @session_counselor).first_or_create(days_attend: "mwf")
      elsif enf_class.one_and_two_tts? || enf_class.three_and_four_tts?
        Instructor.where(enf_class: enf_class, session_counselor: @session_counselor).first_or_create(days_attend: "tts")
      else
        Instructor.where(enf_class: enf_class, session_counselor: @session_counselor).first_or_create(days_attend: class_hash[:days_attend])
      end
    end


    if @session_counselor.save
      flash[:notice] = "You successfully saved the session counselor"
    else
      flash[:alert] = "there was a problem saving the session counselor"
    end
    redirect_to @session_counselor
  end

  def destroy
    @session_counselor = SessionCounselor.find(params[:id])
    cabin_id = @session_counselor.cabin[:id]
    if @session_counselor.destroy
      flash[:notice] = "The session counselor was successfully deleted"
    else
      flash[:alert] = "There was a problem deleting your counselor"
    end
    cabin = Cabin.find(cabin_id)
    redirect_to session_cabin_path(cabin.session, cabin)
  end

  private

  def session_counselor_params
    params.require(:session_counselor).permit(:table_number, :cabin_id)
  end


end
