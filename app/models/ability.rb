class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.operator?
      can :read, :all
      cannot :manage, User
      can [:read, :create, :update, :destroy], [School, Visit, Division, District, Thana]
    elsif user.viewer?
      can :read, :all
      cannot :manage, User
    end
  end
end
