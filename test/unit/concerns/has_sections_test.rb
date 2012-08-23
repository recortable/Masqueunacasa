require 'test_helper'

describe HasSections do
  it 'add editor when create a proposal' do
    User.current_user = create(:user)
    proposal = create(:proposal)
    proposal.editor?(User.current_user).must_equal true
  end

  it 'add editor when add section' do
    user = create(:user)
    doc = create(:proposal)
    doc.add_section(build(:section), user)
    doc.editor?(user).must_equal true
  end

end

