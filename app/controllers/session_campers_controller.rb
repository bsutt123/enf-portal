class SessionCampersController < ApplicationController
  def show
    @session_camper = SessionCamper.find(params[:id])
  end

  def edit
    @session_camper = SessionCamper.find(params[:id])
    @enf_classes = @session_camper.session.enf_classes
  end

  def update
    @session_camper = SessionCamper.find(params[:id])
    @session_camper.assign_attributes(session_camper_params)
    enf_classes = params[:session_camper][:students_attributes].values
    enf_classes.each do |class_hash|
      enf_class = EnfClass.find(class_hash[:enf_class_id].to_i)
      if enf_class.one_and_two_mwf? || enf_class.three_and_four_mwf?
        Student.where(enf_class: enf_class, session_camper: @session_camper).first_or_create(days_attend: "mwf")
      elsif enf_class.one_and_two_tts? || enf_class.three_and_four_tts?
        Student.where(enf_class: enf_class, session_camper: @session_camper).first_or_create(days_attend: "tts")
      else
        Student.where(enf_class: enf_class, session_camper: @session_camper).first_or_create(days_attend: class_hash[:days_attend])
      end
    end


    if @session_camper.save
      flash[:notice] = "You successfully saved the session camper"
    else
      flash[:alert] = "there was a problem saving the session camper"
    end
    redirect_to @session_camper
  end

  def destroy
    @session_camper = SessionCamper.find(params[:id])
    @cabin = @session_camper.cabin
    if @session_camper.destroy
      flash[:notice] = "The session camper was successfully deleted"
    else
      flash[:alert] = "There was a problem deleting your camper"
    end

    redirect_to @cabin

  end

  private

  def session_camper_params
    params.require(:session_camper).permit(:table_number, :cabin_id)
  end


end
