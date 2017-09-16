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
    @trip = Trip.find(params[:trip_id])
    @food = @trip.food

    if @food.destroy
      flash[:notice] = "You successfully deleted the food form"
    else
      flash[:alert] = "There was a problem deleting this food form"
    end
    redirect_to @trip
  end

  def show

    @trip = Trip.find(params[:trip_id])
    @food = Food.find(params[:id])
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
    @trip = Trip.find(params[:trip_id])
    @food = Trip.food
    @food.assign_attributes(trip_food_params)

    if @food.save
      flash[:notice] = 'Your food form was succesfully updated'
    else
      flash[:alert] = "There was a problem saving your food form"
    end
    redirect_to @trip
  end

  private

  def trip_food_params
    params.require(:food).permit!
  end
end
