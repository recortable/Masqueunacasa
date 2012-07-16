# encoding: utf-8
require 'test_helper'

describe Experiencie do
  it 'have unique titles' do
    create(:experiencie, title: 'Exp')
    e = build(:experiencie, title: 'Exp')
    e.save.must_equal false
  end

  it 'search by title ordered by title asc' do
    exp1 = create(:experiencie, title: 'Esto es una prueba')
    exp2 = create(:experiencie, title: 'Esto es otra prueba')
    create(:experiencie, title: 'No debería encontrarlo')
    results = Experiencie.search('prueba')
    results.count.must_equal 2
    results.first.must_equal exp2
    results.last.must_equal exp1
  end

  it 'find for phase' do
    p1 = create(:proposal)
    e1 = create(:experiencie)
    p1.add_relation(e1, create(:user))

    p2 = create(:proposal, phase: p1.phase)
    e2 = create(:experiencie)
    p2.add_relation(e2, create(:user))

    es = Experiencie.all_for_phase(proposal.phase)
    es.count.must_equal 2
  end
end
