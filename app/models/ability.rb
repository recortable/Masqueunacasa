class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Phase
    can :read, Proposal

    if user.blank?
      can :new, UserSession 
    elsif user.admin?
      can :manage, :all
    else
      can :new, Proposal
      can :create, Proposal
      can :read, Membership
      cannot :new, UserSession

      can :edit, Group do |group|
        group.member_level?(user, [:owner, :member])
      end

      can :manage, Post do |post|
        group = post.group
        group.member_level?(user, [:owner, :member])
      end

      can :manage, Page do |page|
        group = page.group
        group.member_level?(user, [:owner, :member])
      end
    end
  end
end
