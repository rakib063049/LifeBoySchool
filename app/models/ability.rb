class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.role?(:operator)
      can :manage, [:school, :visit]
    end
  end
end
