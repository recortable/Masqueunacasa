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

  it 'create versions' do
    proposal = create(:proposal, group: create(:group))
    Version.count.must_equal 1
    v = Version.last
    v.title.must_equal proposal.title
    v.group_id.must_equal proposal.group_id
  end

  it 'can relate to an experiencie' do
    user = create(:user)
    proposal = create(:proposal)
    experiencie = create(:experiencie)

    proposal.add_relation(experiencie, user)
    proposal.relations.count.must_equal 1
    proposal.experiencies.first.must_equal experiencie
  end

  it 'has sections by lang' do
    p = create(:proposal)
    es = create(:section, document: p, lang: 'es')
    ca = create(:section, document: p, lang: 'ca')
    I18n.locale = 'es'
    p.sections.size.must_equal 1
    p.sections.first.must_equal es
    I18n.locale = 'ca'
    p.sections.size.must_equal 1
    p.sections.first.must_equal es
  end
end
