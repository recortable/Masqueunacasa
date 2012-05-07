class Authorizations::Anonymous < Authorizations::Base
  
  def initialize
    can :new, UserSession
  end
end
