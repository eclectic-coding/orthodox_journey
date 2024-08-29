class AdminPolicy < ApplicationPolicy
  attr_reader :user

  def show?
    user.admin?
  end
end
