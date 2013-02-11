require 'spec_helper'

describe "Profile integration", require_main_group: true do
  it "edit profile" do
    group = setup_group

    visit edit_profile_path
    fill_in 'group_name', with: 'Newname'
    fill_in 'group_title', with: 'The title'
    fill_in 'group_summary', with: 'New group summary'
    click_submit

    group.reload
    expect( group.name ).to eq 'Newname'
    expect( group.title ).to eq 'The title'
    expect( group.summary ).to eq 'New group summary'
  end
end
