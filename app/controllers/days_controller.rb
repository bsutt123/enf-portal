class DaysController < ApplicationController
  def show
    @day = Day.find(params[:id])
    @session = @day.session
  end

  def edit
    @day = Day.find(params[:id])
  end

  def new

  end

  def create

  end

  def update

  end

  def destroy

  end

end
