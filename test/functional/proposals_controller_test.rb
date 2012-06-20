require 'test_helper'

describe 'Proposals integration' do
  it 'list proposals' do
    proposal = create(:proposal)
    visit proposals_path
    page.text.must_include proposal.title
  end

  it 'shows proposal' do
    proposal = create(:proposal)
    visit proposal_path(proposal)
    page.text.must_include proposal.title
    page.text.must_include proposal.body
  end

  it 'can create proposals' do
    login_user create(:user)
    visit proposals_path
    page.find("a[rel='new-proposal']")
  end

  it 'creates proposals' do
    user = create(:user)
    login_user user
    phase = create(:phase)
    visit new_proposal_path
    page.fill_in 'proposal_title', with: 'My proposal'
    page.fill_in 'proposal_description', with: 'My proposal description'
    page.fill_in 'proposal_body', with: 'My proposal body'
    page.select phase.title, from: 'proposal_phase_id'
    click_submit
    Proposal.count.must_equal 1
    proposal = Proposal.last
    proposal.user.must_equal user
    proposal.title.must_equal 'My proposal'
    proposal.description.must_equal 'My proposal description'
    proposal.body.must_equal 'My proposal body'
    proposal.phase.must_equal phase
  end

  it 'updates proposals' do
    user = create(:user)
    login_user user
    proposal = create(:proposal, user: user)
    visit edit_proposal_path(proposal)
    page.fill_in 'proposal_title', with: 'New title'
    click_submit
    proposal.reload
    proposal.title.must_equal 'New title'
  end

end
