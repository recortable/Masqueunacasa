require 'test_helper'

describe 'Profile integration' do
  it 'edit profile' do
    group = create(:group)
    login_user group.user
    subdomain(group.subdomain)

    visit edit_profile_path
    fill_in 'group_name', with: 'New name'
    fill_in 'group_summary', with: 'New group summary'
    click_submit

    group.reload
    group.summary.must_equal 'New group summary'
    group.name.must_equal 'New name'
  end
end
