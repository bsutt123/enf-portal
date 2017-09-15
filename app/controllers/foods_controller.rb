class FoodsController < ApplicationController
  def new
    @trip = Trip.find(params[:trip_id])
    @food = Food.new
  end

  def edit
    @trip = Trip.find(params[:trip_id])
    @food = Food.find(params[:id])
  end

  def destroy

  end

  def create
    @trip = Trip.find(params[:trip_id])
    @food = Food.create(trip_food_params)
    @trip.food = @food

    if @food.save
      flash[:notice] = "You food form was successfully saved"
    else
      flash[:alert] = "There was a problem saving your food form"
    end
    redirect_to @trip

  end

  def update

  end

  private

  def trip_food_params
    params.require(:food).permit!
  end
end
