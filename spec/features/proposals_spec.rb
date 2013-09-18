require 'spec_helper'

describe "Proposals integration" do
  let( :user ) { login_user create(:user) }
  let( :proposal ) { create :proposal }
  let( :relation ) { create :relation }

  subject { page }

  it "shows proposal" do
    visit proposal_path(proposal)
    should have_text proposal.title
    should have_text proposal.summary
  end

  it "shows proposal links"

  it "shows proposal relations" do
    visit proposal_path(relation.proposal)
    should have_text relation.experiencie.title
  end

  it "can create relation" do
    user
    visit proposal_path(proposal)
    f_link("new-relation").click
  end

  it "creates proposals" do
    user
    cat = FactoryGirl.create( :category )
    visit new_category_proposal_path( cat )
    fill_in 'proposal_title', with: 'My proposal'
    fill_in 'proposal_summary',
      with: 'My proposal summary'
    click_submit
    expect( Proposal.count ).to eq 1
    new_proposal = Proposal.last
    expect( new_proposal.user ).to eq user
    expect( new_proposal.title ).to eq 'My proposal'
    expect( new_proposal.summary).to eq 'My proposal summary'
    expect( new_proposal.category).to eq cat
    expect( new_proposal.phase).to eq cat.phase
  end

  it "updates proposals" do
    user
    visit edit_proposal_path(proposal)
    fill_in 'proposal_title', with: 'New title'
    click_submit
    should have_text 'New title'
  end
end
