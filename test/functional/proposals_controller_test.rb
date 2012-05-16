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
    visit new_proposal_path
    page.fill_in 'proposal_title', with: 'My proposal'
    page.fill_in 'proposal_body', with: 'My proposal body'
    click_submit
    Proposal.count.must_equal 1
    proposal = Proposal.last
    proposal.user.must_equal user
    proposal.title.must_equal 'My proposal'
    proposal.body.must_equal 'My proposal body'
  end

end
