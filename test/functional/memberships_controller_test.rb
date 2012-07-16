require 'test_helper'

describe 'Memberships integration' do
  it 'list group memberships' do
    member = create(:user)
    group = create(:group)
    group.add_member(member)
    nonmember = create(:user)

    login_user(member)
    subdomain(group.subdomain)
    visit edit_profile_path

    page.text.must_include member.name
    page.text.wont_include nonmember.name
  end

  it 'can add member' do
    group = setup_group

    visit edit_profile_path
    find_link('new-membership').click
  end

  it 'adds member' do
    group = setup_group

    user = create(:user)
    visit new_membership_path
    page.text.must_include user.title
    find_link("add-member-user-#{user.id} nofollow").click
    group.member?(user).must_equal true
  end

  it 'deletes member' do
    group = setup_group
    membership = group.add_member(create(:user))

    visit edit_profile_path
    puts page.html
    find_link("delete-membership-#{membership.id} nofollow").click
    group.member?(membership.user).must_equal false
  end

  def setup_group
    group = create(:group)
    login_user group.user
    subdomain(group.subdomain)
    group
  end
end
