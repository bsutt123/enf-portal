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

    session_counselor_ids = params[:enf_class][:session_counselor_ids]

    create_instructors(session_counselor_ids, @enf_class)
    if @enf_class.save
      flash[:notice] = "Your class was successfully saved"
      redirect_to [@session, @enf_class]
    else
      flash[:alert] = "There was a problem saving your class"
      redirect_to @session
    end
  end

  def destroy
    @session = Session.find(params[:session_id])
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
    session_counselor_ids = params[:enf_class][:session_counselor_ids]

    @enf_class.assign_attributes(enf_class_params)

    detonate_instructors(@enf_class)

    create_instructors(session_counselor_ids, @enf_class)
    if @enf_class.save
      flash[:notice] = "Your class was successfully saved"
    else
      flash[:alert] = "There was a problem saving your class"
    end
    redirect_to [@session, @enf_class]

  end

  private

  def enf_class_params
    params.require(:enf_class).permit(:name, :period)
  end

  def create_students(array, enf_class)
    array.each do |s_camper_id|
      if s_camper_id != ""
        Student.create(session_camper: SessionCamper.find(s_camper_id), enf_class: enf_class)
      end
    end
  end

  def create_instructors(array, enf_class)
    array.each do |s_counselor_id|
      if s_counselor_id != ""
        Instructor.create(session_counselor: SessionCounselor.find(s_counselor_id), enf_class: enf_class)
      end
    end
  end

  def detonate_students(enf_class)
    students = enf_class.students
    students.each do |student|
      student.destroy
    end
  end

  def detonate_instructors(enf_class)
    instructors = enf_class.instructors
    instructors.each do |instructor|
      instructor.destroy
    end
  end

end
