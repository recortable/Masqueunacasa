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

  it 'has proposals counter' do
    p = create(:proposal)
    e = create(:experiencie)
    p.add_relation(e, p.user)

    e.reload
    e.proposals_count.must_equal 1
  end
end
