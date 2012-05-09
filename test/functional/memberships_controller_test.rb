require 'test_helper'

describe 'Memberships integration' do
  it 'list group memberships' do
    group = create(:group)
    member = create(:user)
    group.add_member(member)
    nonmember = create(:user)

    login_user(member)
    subdomain(group.slug)
    visit memberships_path
    page.text.must_include member.name
    page.text.wont_include nonmember.name
  end
end
