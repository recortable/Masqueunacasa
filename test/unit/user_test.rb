require 'test_helper'

describe User do
  it 'requires name, email and password' do
    user = create(:user)
    user.must_be :present?
  end

  it 'has created groups' do
    user = create(:user)
    group = create(:group, user: user)
    user.created_groups.must_include group
  end

  it 'has groups' do
    user = create(:user)
    owned = create(:group, user: user)
    group = create(:group)
    group.add_member(user)
    user.groups.must_include owned
    user.groups.must_include group
  end

  it 'can check membership' do
    user = create(:user)
    group = create(:group)
    group.add_member(user)
    user.member?(group).must_equal true
    group.user.member?(group).must_equal true
  end

end
