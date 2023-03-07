class CustomerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    authorized?
  end

  def update?
    authorized?
  end
end
