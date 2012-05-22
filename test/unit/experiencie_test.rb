require 'test_helper'

describe Experiencie do
  it 'have unique titles' do
    create(:experiencie, title: 'Exp')
    e = build(:experiencie, title: 'Exp')
    e.save.must_equal false
  end
end
