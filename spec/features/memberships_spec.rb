require 'spec_helper'

describe "Memberships integration", require_main_group: true do
  let( :user ) { create :user }

  it "list group members" do
    member = user
    group = FactoryGirl.create( :group )
    group.add_member member
    non_member = FactoryGirl.create( :user )

    login_user( member )
    subdomain( group.subdomain )
    visit edit_profile_path

    expect( page ).to have_text member.name
    expect( page ).to_not have_text non_member.name
  end

  it "can add member" do
    group = setup_group

    visit edit_profile_path
    f_link( 'new-membership' ).click
  end

  it "adds member" do
    group = setup_group
    user
    visit new_membership_path
    expect( page ).to have_text user.title
  end

  it "deletes member" do
    group = setup_group
    membership = group.add_member( create :user )

    visit edit_profile_path
    f_link( "delete-membership-#{membership.id} nofollow" ).click
    expect( group.member?(membership.user) ).to be_false
  end

  def setup_group
    group = FactoryGirl.create( :group )
    login_user group.user
    subdomain( group.subdomain )
    group
  end
end
