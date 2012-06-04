require 'test_helper'

describe 'Groups integration' do
  it 'list groups' do
    g1 = create(:group)
    g2 = create(:group)
    visit groups_path
    page.text.must_include g1.name
    page.text.must_include g2.name
  end

  it 'can create group' do
    user = create(:user)
    login_user user
    visit groups_path
    page.find 'a[rel="new-group"]'
  end

  it 'create group' do
    user = create(:user, admin: true)
    login_user(user)
    visit new_group_path
    fill_in 'group_name', with: 'Name'
    fill_in 'group_description', with: 'Description'
    click_submit
    group = Group.last
    group.name.must_equal 'Name'
    group.description.must_equal 'Description'
  end

  it 'can close a group' do
    group = create(:group)
    login_user group.user
    puts group.inspect
    puts group.user.inspect
    puts group.memberships.inspect
    subdomain(group.subdomain)

    visit edit_profile_path
    page.check('group_closed')
    click_submit
    group.reload.closed?.must_equal true
  end
end
