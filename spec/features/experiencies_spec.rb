require 'spec_helper'

describe "Experiencies integration" do
  let( :exp ) { create :experiencie }
  let( :user) { create :user }

  subject { page }

  it "lists experiencies" do
    exp
    visit experiencies_path
    expect( page ).to have_content exp.title
  end

  it "shows experience" do
    visit experiencie_path(exp)
    should have_content exp.title
    should have_content exp.summary
  end

  # EXTERNAL LINKS
  it "shows the related links" do
    login_user( user )
    link = FactoryGirl.build( :link )
    exp.add_link( link, user )

    visit experiencie_path(exp)
    should have_text link.caption
  end

  it "can create link if current user" do
    login_user( user )
    visit experiencie_path(exp)
    f_link 'new-link'
  end

  it "can create experiencie if user" do
    login_user( user )
    visit experiencies_path
    f_link 'new-experiencie'
  end

  it "can create experience" do
    login_user( user )
    visit new_experiencie_path
    fill_in 'experiencie_title', with: 'The title'
    click_submit
    e = Experiencie.last
    expect( e.title ).to eq 'The title'
    should have_text e.title
  end

  it "can update experience" do
    login_user( user )
    visit edit_experiencie_path( exp )
    fill_in 'experiencie_title', with: 'My experiencie'
    click_submit
    exp.reload
    expect( exp.title ).to eq 'My experiencie'
    should have_text exp.title
  end
end
