class CounselorsController < ApplicationController
  def index
    @counselors = Counselor.all
  end

  def show
    @counselor = Counselor.find(params[:id])
  end

  def edit
    @counselor = Counselor.find(params[:id])
  end

  def new
    @counselor = Counselor.new
    @user = User.new
  end

  def create
    @counselor = Counselor.new(counselor_params)
    @user = User.create(email: params[:user][:email], password: "enfstaff123", password_confirmation: "enfstaff123")
    @counselor.user = @user
    if @counselor.save
      flash[:notice] = "You successfully saved a counselor"
      redirect_to @counselor
    else
      flash[:alert] = "There was a problem saving the counselor"
      redirect_to root_path
    end
  end

  def update
    @counselor = Counselor.find(params[:id])
    @counselor.assign_attributes(counselor_params)
    if @counselor.save
      flash[:notice] = "You successfully changed the counselors information"
      redirect_to @counselor
    else
      flash[:alert] = "There was a problem saving the changes. Please try again."
      redirect_to root_path
    end
  end

  def destroy
    @counselor = Counselor.find(params[:id])
    @user = User.find(@counselor[:user_id])

    couns_bool = @counselor.destroy
    user_bool = @user.destroy

    if couns_bool && user_bool
      flash[:notice] = "You successfully destroyed the counselor!"
      redirect_to root_path
    elsif couns_bool
      flash[:alert] = "The counselor was removed, but the user was not"
      redirect_to root_path
    elsif user_bool
      flash[:alert] = "The user was destroyed but the counselor was not"
      redirect_to root_path
    else
      flash[:alert] = "Neither the counselor nor the user were destroyed"
      redirect_to root_path
    end

  end



  private

  def counselor_params
    params.require(:counselor).permit(:name)
  end

end
