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
    can :manage, Notice

    if user.blank?
      can :create, UserSession 
    elsif user.admin?
      can :manage, :all
    else
      # Un usuario cualquiera
      can :create, Group

      # HABITAPEDIA
      can :manage, Section do |section|
        can? :update, section.document
      end

      can :update, Category
      can :manage, Proposal
      can :destroy, Proposal do |proposal|
        proposal.user_id == user.id
      end
      can [:create, :update], Experiencie
      can :create, Relation
      can(:destroy, Relation) {|relation| relation.user_id == user.id }


      can :manage, Task

      can :read, Membership
      can(:manage, Membership) {|m| participant?(m.group, user) }

      cannot :update, UserSession

      can(:update, User) { |usr| usr == user }
      can(:update, Group) {|group| participant?(group, user) }

      can(:manage, Post) {|post| participant?(current_group, user) }
      can(:destroy, Post) {|post| post.user_id == user.id }

      can(:manage, Page) {|page| participant?(page.group, user) }
      can(:manage, Announcement) {|ann| participant?(ann.group, user) }
      cannot :destroy, Announcement
    end
  end

  protected
  def participant?(group, user)
    group.member?(user)
  end
end
