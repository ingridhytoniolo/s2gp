class MeetingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    true
  end

  def destroy?
    user.admin? || user.profile.id == record.profile_id
  end

  def edit?
    update?
  end

  def update?
    user.admin? || user.profile.id == record.profile_id
  end
end
