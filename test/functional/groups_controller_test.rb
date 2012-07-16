require 'test_helper'

describe 'Groups integration' do
  it 'list groups' do
    g1 = create(:group)
    g2 = create(:group)
    visit groups_path
    page.text.must_include g1.name
    page.text.must_include g2.name
  end

  it 'create group' do
    user = create(:user, admin: true)
    login_user(user)
    visit new_group_path

    fill_in 'group_name', with: 'Name'
    fill_in 'group_summary', with: 'summary'

    click_submit
    group = Group.last
    group.name.must_equal 'Name'
    group.summary.must_equal 'summary'
  end

  it 'shows group in its own subdomain' do
    group = create(:group)
    subdomain(group.subdomain)

    visit root_path
  end
end
