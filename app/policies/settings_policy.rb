class SettingsPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  
  def delete_image?
    user.admin?
  end

  def edit?
    update?
  end
  
  def index?
    user.admin?
  end

  def update?
    user.admin?
  end
end
