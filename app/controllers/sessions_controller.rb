class SessionsController < ApplicationController
  def index
    @sessions = Session.all
  end

  def show
    @session = Session.find(params[:id])
  end

  def new
    @session = Session.new
  end

  def edit
    @session = Session.find(params[:id])
  end

  def create
    @session = Session.new(session_params)
    session_number = params[:session][:number]
    session_year = params[:session]["start(1i)"]
    @session.assign_attributes(identifier: "session_#{session_number}_#{session_year}")
    if @session.save
      flash[:notice] = "You successfully saved a session"
      redirect_to @session
    else
      flash[:alert] = "There was a problem saving the session"
      redirect_to root_path
    end
  end

  def update
    @session = Session.find(params[:id])
    @session.assign_attributes(session_params)

    if @session.save
      flash[:notice] = "You successfully saved a session"
      redirect_to @session
    else
      flash[:alert] = "There was a problem saving the session"
      redirect_to root_path
    end
  end

  def destroy
    @session = Session.find(params[:id])

    if @session.destroy
      flash[:notice] = "Session was successfully deleted"
      redirect_to root_path
    else
      flash[:alert] = "There was a problem deleting the session"
      redirect_to root_path
    end
  end



  private

  def session_params
    params.require(:session).permit(:number, :start, :finish)
  end

end