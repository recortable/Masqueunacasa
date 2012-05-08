module MembershipsHelper

  def create_membership_path(user, level = 'member')
    memberships_path(u: user, l: level)
  end
end
