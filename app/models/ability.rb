class Ability
  include CanCan::Ability

  # Usemos solo :read, :create, :update, :destroy
  # NO USEMOS: :index, :view, :edit, :new
  def initialize(user, current_group)
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

    if user.blank?
      can :create, UserSession 
    elsif user.admin?
      can :manage, :all
    else
      # Un usuario cualquiera

      # HABITAPEDIA
      can :update, Category
      can :manage, Section do |section|
        can? :update, section.document
      end
     
      can :create, Group

      can [:create, :update], Experiencie

      can :manage, Proposal
      can :delete, Proposal do |proposal|
        proposal.user_id == user.id
      end

      can :read, Membership
      cannot :update, UserSession

      can(:update, User) { |usr| usr == user }
      can(:update, Group) {|group| participant?(group, user) }
      can(:manage, Post) {|post| participant?(post.group, user) }
      can(:manage, Page) {|page| participant?(page.group, user) }
      can(:manage, Announcement) {|ann| participant?(ann.group, user) }
      cannot :delete, Announcement
    end
  end

  protected
  def participant?(group, user)
    group.member_level?(user, [:owner, :member])
  end
end
