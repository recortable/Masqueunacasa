require 'test_helper'

describe Relation do
  it 'has phase and category' do
    p = create(:proposal)
    e = create(:experiencie)
    u = create(:user)

    puts p.inspect
    r = Relation.create(proposal: p, experiencie: e, user: u)
    r.phase.must_equal p.phase
    r.category.must_equal p.category
  end
end
