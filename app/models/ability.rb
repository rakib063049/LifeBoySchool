class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.role?(:operator)
      can :read, :all
      cannot :manage, User
      can [:read, :create, :update, :destroy], [School, Visit, Division, District, Thana, Union]
    end
  end
end
