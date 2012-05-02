require 'test_helper'

describe 'Profile integration' do
  it 'edit profile' do
    group = create(:group)
    subdomain(group.slug)
    visit edit_profile_path
    #fill_in 'group_name', with: 'New name'
    fill_in 'group_description', with: 'New group description'
    click_submit
    group.reload
    #group.name.must_equal 'New name'
    group.description.must_equal 'New group description'
  end
end
