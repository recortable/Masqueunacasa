require 'spec_helper'

describe "Groups integration", require_main_group: true do
  subject { page }

  it "list groups" do
    groups = FactoryGirl.create_list( :group, 2 )
    visit groups_path
    should have_text groups[0].name
    should have_text groups[1].name
  end

  it "create a group" do
    user = login_user( create(:user) )
    visit new_group_path

    fill_in 'group_name', with: 'Name'
    fill_in 'group_title', with: 'Group title'
    fill_in 'group_summary', with: 'summary'

    click_submit
    group = Group.last

    expect( group.name ).to eq 'Name'
    expect( group.title ).to eq 'Group title'
    expect( group.summary ).to eq 'summary'
  end

  it "show group in its own subdomain" do
    group = FactoryGirl.create( :group )
    subdomain( group.subdomain )

    visit root_path
  end
end
