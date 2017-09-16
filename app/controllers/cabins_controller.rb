class CabinsController < ApplicationController
  def index
    @cabins = Cabin.all
  end

  def show
    @cabin = Cabin.find(params[:id])
  end

  def new
    @cabin = Cabin.new
    authorize @cabin
  end

  def edit
    @cabin = Cabin.find(params[:id])
    authorize @cabin
  end


  def create
    @cabin = Cabin.new(cabin_params)
    authorize @cabin
    @cabin.assign_attributes(identifier: "Cabin #{@cabin.number} #{@cabin.session[:identifier]}" )
    if @cabin.save
      flash[:notice] = "You successfully saved the cabin"
      redirect_to [@cabin.session, @cabin]
    else
      flash[:alert] = "There was a problem saving the cabin"
      redirect_to root_path
    end
  end

  def update
    @cabin = Cabin.find(params[:id])

    authorize @cabin
    @cabin.assign_attributes(cabin_params)
    camper_ids = params[:cabin][:camper_ids]
    counselor_ids = params[:cabin][:counselor_ids]

    detonate_session_campers(@cabin)
    detonate_session_counselors(@cabin)

    create_session_campers(camper_ids, @cabin)
    create_session_counselors(counselor_ids, @cabin)

    if @cabin.save
      flash[:notice] = "You successfully edited the cabin."
    else
      flash[:alert] = "There was a problem saving your cabin"
    end
    redirect_to [@cabin.session, @cabin]
  end

  def destroy
    @cabin = Cabin.find(params[:id])
    authorize @cabin
    if @cabin.destroy
      flash[:notice] = "Cabin was successfully deleted."
    else
      flash[:alert] =  "There was a problem deleting your cabin"
    end
    redirect_to root_path
  end

  private

  def cabin_params
    params.require(:cabin).permit(:number, :session_id)
  end

  def detonate_session_campers(cabin)
    session_campers = cabin.session_campers
    session_campers.each do |camper|
      camper.destroy
    end
  end

  def detonate_session_counselors(cabin)
    session_counselors = cabin.session_counselors
    session_counselors.each do |counselor|
      counselor.destroy
    end
  end

  def create_session_campers(array, cabin)
    array.each do |camper_id|
      if camper_id != ""
        SessionCamper.create(cabin: @cabin, session: @cabin.session, camper: Camper.find(camper_id))
      end
    end
  end

  def create_session_counselors(array, cabin)
    array.each do |counselor_id|
      if counselor_id != ""
        SessionCounselor.create(cabin: @cabin, session: @cabin.session, counselor: Counselor.find(counselor_id))
      end
    end
  end

end
