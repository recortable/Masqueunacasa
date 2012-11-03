class Ability
  include CanCan::Ability


  # Usemos solo :read, :create, :update, :destroy
  # NO USEMOS: :index, :view, :edit, :new
  def initialize(user, current_group)
    anonymous_abilities

    if user.blank?
      no_user_abilities
    else
      cannot :update, UserSession
      can :manage, Section do |section|
        can? :update, section.document
      end
      habitapedia_abilities(user)
      social_abilities(user, current_group)
      admin_abilities if user.admin?
    end
  end

  def habitapedia_abilities(user)
      can :update, Category
      can :manage, Proposal
      can :destroy, Proposal do |proposal|
        proposal.user_id == user.id
      end
      can [:create, :update], Experiencie
      can :create, Relation
      can(:destroy, Relation, user_id: user.id)
  end

  def social_abilities(user, current_group)
      can(:update, User, user_id: user.id)

      can :create, Group
      can(:update, Group) {|group| participant?(group, user) }
      can :read, Membership
      can(:manage, Membership) {|m| participant?(m.group, user) }

      can(:manage, Post) {|post| participant?(current_group, user) }
      can(:destroy, Post, user_id: user.id)
      can(:manage, Page) {|page| participant?(page.group, user) }
      can(:manage, Announcement) {|ann| participant?(ann.group, user) }
      cannot :destroy, Announcement
  end

  def anonymous_abilities
    # Any user
    can :read, Phase
    can :read, Proposal
    cannot :index, Proposal
    can :read, Group
    can [:read, :index], Experiencie
    can :read, Category
    cannot :index, Category
    can :read, Agent
    can :read, Post
    can :manage, Notice
  end

  def no_user_abilities
    can :create, UserSession 
  end

  def admin_abilities
    can :manage, Phase
    can :manage, Category
    can :manage, Notice
  end

  protected
  def participant?(group, user)
    group.member?(user)
  end
end
