#
class HomePagePolicy < ApplicationPolicy
  def index?
    false
  end

  def create?
    false
  end

  def destroy?
    false
  end
end
