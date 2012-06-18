require 'test_helper'

describe Section do
  it 'has proposal_title' do
    s = create(:section)
    s.proposal_title.must_equal s.proposal.title
  end

  it 'has position' do
    s = create(:section)
    s.position.must_be :present?
  end
end
