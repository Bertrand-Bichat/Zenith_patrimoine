class ContractPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    authorized?
  end

  def update?
    authorized? && (admin? || super_admin? || (record.customer.user == user))
  end
end
