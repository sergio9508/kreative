#
class AboutPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    false
  end

  def index?
    false
  end

  def destroy?
    false
  end
end
