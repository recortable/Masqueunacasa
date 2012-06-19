require 'test_helper'

describe Section do

  it 'has document_title' do
    proposal = create(:proposal)
    s = create(:section, document: proposal)
    s.document_title.must_equal proposal.title
  end

  it 'has position' do
    proposal = create(:proposal)
    create(:section, document: proposal).position.must_equal 1
    create(:section, document: proposal).position.must_equal 2
    experiencie = create(:experiencie)
    create(:section, document: experiencie).position.must_equal 1
    create(:section, document: experiencie).position.must_equal 2
  end
end
