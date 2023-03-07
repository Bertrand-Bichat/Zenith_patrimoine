class CriterionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    # super_admin?
    false
  end

  def update?
    # super_admin?
    false
  end

  def destroy?
    # super_admin?
    false
  end
end
