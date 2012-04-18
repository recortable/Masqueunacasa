class Ability
  include CanCan::Ability

  def initialize(user)
    if user.blank?
      can :create, User
    else
      can :manage, User
      can :manage, Group
    end
  end
end
