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
end
