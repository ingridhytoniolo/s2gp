class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def edit?
    update?
  end

  def update?
    true
  end

  def new_avatar?
    true
  end

  def delete_avatar?
    true
  end
end
