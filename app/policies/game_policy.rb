class GamePolicy < ApplicationPolicy

  def add?
    user.present?
  end

  def remove?
    user.present?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      user ? scope.enabled.order(:title) : scope.none
    end
  end

end
