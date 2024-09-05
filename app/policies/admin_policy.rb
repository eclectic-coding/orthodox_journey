class AdminPolicy < ApplicationPolicy
  attr_reader :user

  def index?
    user.admin?
  end

  def show?
    user.admin?
  end
end
