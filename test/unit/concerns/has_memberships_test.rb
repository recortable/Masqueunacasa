require 'test_helper'

describe HasMemberships do
  it "create owner membership" do
    group = create(:group)
    group.user.must_be :present?
    m = group.memberships.first
    m.user.must_equal group.user
    m.state.must_equal 'owner'
  end

  it "adds a new member" do
    group = create(:group)
    member = create(:user)
    group.add_member(member)
    m = Membership.last
    m.group.must_equal group
    m.user.must_equal member
    m.state.must_equal 'member'
  end

  it "does not add member if exist" do
    group = create(:group)
    member = create(:user)
    group.add_member(member, :member)
    group.add_member(member, :owner)
    group.member_level?(member, :owner).must_equal false
  end

  it "adds a new follower" do
    group = create(:group)
    follower = create(:user)
    group.add_member(follower, :follow)
    m = group.memberships.last
    m.user.must_equal follower
    m.state.must_equal 'follow'
  end

  it "checks member level" do
    group = create(:group)
    owner = group.user

    group.member_level?(owner, :owner).must_equal true
    group.member_level?(owner, [:owner, :member]).must_equal true
    
    member = create(:user)
    group.add_member(member, :member)
    group.member_level?(member, :member).must_equal true
  end

  it "has membership for user" do
    group = create(:group)
    group.membership_for(group.user).must_be :present?
  end

  it "check membership" do
    group = create(:group)
    user = create(:user)
    group.add_member(user)
    group.member?(user).must_equal true
  end

end
