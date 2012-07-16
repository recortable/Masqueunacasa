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
end
