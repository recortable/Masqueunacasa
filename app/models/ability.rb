class Ability
  include CanCan::Ability


  # Usemos solo :read, :create, :update, :destroy
  # NO USEMOS: :index, :view, :edit, :new
  def initialize(user)
    anonymous_abilities

    if user.blank?
      no_user_abilities
    else
      cannot :update, UserSession
      can :manage, Section do |section|
        can? :update, section.document
      end
      habitapedia_abilities(user)
      social_abilities(user)
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

  def social_abilities(user)
      can(:update, User, id: user.id)
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
    can :read, User
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
