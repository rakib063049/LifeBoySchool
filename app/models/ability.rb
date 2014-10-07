class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin? || user.agency_admin?
      can :manage, :all
    elsif user.operator?
      can :read, :all
      can :manage, School
      cannot :manage, User
    elsif user.viewer?
      can :read, :all
      cannot :manage, User
    else
      can :read, :all
      cannot :manage, User
    end
  end
end
