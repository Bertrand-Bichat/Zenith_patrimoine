class DelegationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    super_admin?
  end

  def destroy?
    super_admin?
  end
end
