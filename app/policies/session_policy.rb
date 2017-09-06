class SessionPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def delete?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def new?
    user.admin?
  end

end
