require 'test_helper'

describe HasMemberships do
  it "create owner membership" do
    group = create(:group)
    m = group.memberships.first
    m.user.must_equal group.user
  end

  it "adds a new member" do
    group = create(:group)
    member = create(:user)
    group.add_member(member)
    m = Membership.last
    m.group.must_equal group
    m.user.must_equal member
  end

  it "has membership for user" do
    group = create(:group)
    group.membership_for(group.user).must_be :present?
  end

  it "has not membership for no user" do
    group = create(:group)
    group.membership_for(nil).must_equal nil
  end

  it "check membership" do
    group = create(:group)
    user = create(:user)
    group.add_member(user)
    group.member?(user).must_equal true
  end

end
