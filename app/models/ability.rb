class Ability
  include CanCan::Ability

  def initialize(user)
    if user.blank?
      can :create, User
      can :new, UserSession
    else
      can :manage, Post
      can :manage, User
      can :manage, Group
    end
  end
end
