#
class AdminPolicy < ApplicationPolicy
  def destroy?
    user.id != record.id
  end
end
