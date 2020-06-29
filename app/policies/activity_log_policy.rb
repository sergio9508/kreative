#
class ActivityLogPolicy < ApplicationPolicy
  def create?
    false
  end
end
