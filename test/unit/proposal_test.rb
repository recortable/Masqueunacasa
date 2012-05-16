require 'test_helper'

describe Proposal do
  it 'creates titles and slugs for every lang' do
    user = create(:user)
    phase = create(:phase)
    proposal = Proposal.new(title: 'Title', user: user, phase: phase)
    proposal.save.must_equal true
    proposal.title.must_equal 'Title'
    proposal.title_es.must_be :present?
    proposal.title_ca.must_be :present?
    proposal.slug_es.must_be :present?
    proposal.slug_ca.must_be :present?
  end

  it 'scopes by published' do
    published = create(:proposal, published: true)
    hidden = create(:proposal, published: false)
    Proposal.published.count.must_equal 1
    Proposal.published.first.must_equal published
  end
end
