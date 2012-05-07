class Authorizations::Admin < Authorizations::Base

  def initialize
    can :manage, Post
    can :manage, Group
  end
end
