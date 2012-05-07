require 'test_helper'

describe Group do
  it "create owner membership" do
    group = create(:group)
    group.user.must_be :present?
    m = group.memberships.first
    m.user.must_equal group.user
    m.state.must_equal 'owner'
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
