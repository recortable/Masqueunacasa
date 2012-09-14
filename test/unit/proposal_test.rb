require 'test_helper'

describe Proposal do
  it 'creates titles and slugs for every lang' do
    user = create(:user)
    category = create(:category)
    proposal = Proposal.new(title: 'Title', user: user, category: category)
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

  it 'can relate to an experiencie' do
    user = create(:user)
    proposal = create(:proposal)
    experiencie = create(:experiencie)

    proposal.add_relation(experiencie, user)
    proposal.relations.count.must_equal 1
    proposal.experiencies.first.must_equal experiencie
  end


  # TODO: este test no es necesario. Hace falta hacer una migración para
  # borrar los campos en las relaciones
  it 'updates all relations when category change' do
    p = create(:proposal)
    e = create(:experiencie)
    r = p.add_relation(e, create(:user))

    c2 = create(:category)
    p.category = c2
    p.save
    r.reload
    #r.category.must_equal c2
    #r.phase.must_equal c2.phase
  end

  it 'has experiencies counter' do
    p = create(:proposal)
    p.add_relation(create(:experiencie), p.user)
    p.add_relation(create(:experiencie), p.user)
    p.reload
    p.experiencies_count.must_equal 2
  end
end
