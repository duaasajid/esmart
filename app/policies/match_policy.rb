class MatchPolicy < ApplicationPolicy

  def new?
    create?
  end

  def create?
    user.present?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      user ? scope.all : scope.none
    end
  end

end
