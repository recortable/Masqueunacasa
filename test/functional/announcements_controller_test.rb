require 'test_helper'

describe 'Announcements integration' do
  it 'list announcements' do
    user = create(:user)
    group = create(:group)
    group.add_member(user)
    login_user(user)
    subdomain(group.subdomain)
    
    ann = create(:announcement, group: group)
    visit announcements_path
    page.text.must_include ann.title
  end

  it 'can make an announcement if member' do
    group = create(:group)
    login_user(group.user)
    subdomain(group.subdomain)

    visit announcements_path
    find_link('new-announcement')
  end

  it 'creates announcement' do
    group = create(:group)
    login_user(group.user)
    subdomain(group.subdomain)

    visit new_announcement_path

  end
end
