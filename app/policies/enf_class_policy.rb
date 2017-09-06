class EnfClassPolicy < ApplicationPolicy

  def update?
    user.admin?
  end

  def create?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def new?
    user.admin?
  end

  def delete?
    user.admin?
  end

end
