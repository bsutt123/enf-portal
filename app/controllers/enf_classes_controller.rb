class EnfClassesController < ApplicationController
  def show
    @session = Session.find(params[:session_id])
    @enf_class = @session.enf_classes.find(params[:id])
  end

  def edit
    @session = Session.find(params[:session_id])
    @enf_class = @session.enf_classes.find(params[:id])
  end

  def new
    @session = Session.find(params[:session_id])
    @enf_class = @session.enf_classes.new
  end

  def create
    @session = Session.find(params[:session_id])
    @enf_class = @session.enf_classes.create(enf_class_params)

    if @enf_class.save
      flash[:notice] = "Your class was successfully saved"
      redirect_to [@session, @enf_class]
    else
      flash[:alert] = "There was a problem saving your class"
      redirect_to @session
    end
  end

  def destroy
    @session = Session.find(params[:id])
    @enf_class = @session.enf_classes.find(params[:id])

    if @enf_class.destroy
      flash[:notice] = "You successfully destroyed the class"
      redirect_to @session
    else
      flash[:alert] = "There was a problem destroying the class."
      redirect_to [@session, @enf_class]
    end
  end

  def update
    @session = Session.find(params[:session_id])
    @enf_class = @session.enf_classes.find(params[:id])

    @enf_class.assign_attributes(enf_class_params)

    if @enf_class.save
      flash[:notice] = "Your class was successfully saved"
    else
      flash[:alert] = "There was a problem saving your class"
    end
    redirect_to [@session, @enf_class]

  end

  private

  def enf_class_params
    params.require(:enf_class).permit(:name)
  end


end
