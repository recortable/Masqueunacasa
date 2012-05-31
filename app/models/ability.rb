class Ability
  include CanCan::Ability

  # Usemos solo :read, :create, :update, :destroy
  # NO USEMOS: :index, :view, :edit, :new
  def initialize(user, current_group)
    # Any user
    can :read, Phase
    can :read, Proposal
    can :read, Group
    can [:read, :index], Experiencie
    can :read, Category

    if user.blank?
      can :create, UserSession 
    elsif user.admin?
      can :manage, :all
    else
      can :create, Group

      can [:create, :update], Experiencie

      can :manage, Proposal
      can :delete, Proposal do |proposal|
        proposal.user_id == user.id
      end

      can :read, Membership
      cannot :update, UserSession

      can :update, Group do |group|
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
