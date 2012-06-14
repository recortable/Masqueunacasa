require 'test_helper'

describe Group do
  it "is not a site" do
    create(:group).site?.must_equal false
  end

  it "is not closed by default" do
    closed = create(:group, closed: true)
    closed.closed?.must_equal true
    group = create(:group).closed?.must_equal false
  end

  it 'has recipients' do
    group = create(:group)
    owner = group.user
    member = create(:user)
    group.add_member(member, :member)
    follower = create(:user)
    group.add_member(follower, :follow)

    admin = group.recipients('admin')
    admin.size.must_equal 1 
    admin.must_include owner

    members = group.recipients('members')
    members.size.must_equal 2
    members.must_include owner
    members.must_include member

    all = group.recipients
    all.size.must_equal 3
    [owner, member, follower].each {|u| all.must_include u }
  end
end
