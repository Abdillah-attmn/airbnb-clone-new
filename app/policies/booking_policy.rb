class BookingPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user || user.admin
  end

  def destroy?
    record.user == user || user.admin
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user

      user.admin ? scope.all : scope.where(user: user)
    end
  end
end
