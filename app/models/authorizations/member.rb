class Authorizations::Member < Authorizations::Base

  def initialize
    can :manage, Post
    can :edit, Group
    can :update, Group
  end
end
