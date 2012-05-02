require 'test_helper'

describe 'Users integration' do
  it 'list users of a group' do
    group = create(:group)
    group.add_member(create(:user, name: 'userone'))
    group.add_member(create(:user, name: 'usertwo'))

    subdomain(group.slug)
    visit users_path
    page.text.must_include 'userone'
    page.text.must_include 'usertwo'
  end
end
