require 'test_helper'

describe 'Profile integration' do
  it 'edit profile' do
    group = setup_group

    visit edit_profile_path
    fill_in 'group_name', with: 'Newname'
    fill_in 'group_title', with: 'The title'
    fill_in 'group_summary', with: 'New group summary'
    click_submit

    group.reload
    group.name.must_equal 'Newname'
    group.title.must_equal 'The title'
    group.summary.must_equal 'New group summary'
  end
end
