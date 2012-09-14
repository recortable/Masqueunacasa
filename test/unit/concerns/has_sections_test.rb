require 'test_helper'

describe HasSections do
  it 'has sections by lang' do
    original_locale = I18n.locale
    p = create(:proposal)
    es = create(:section, document: p, lang: 'es')
    ca = create(:section, document: p, lang: 'ca')
    I18n.locale = 'es'
    p.sections.size.must_equal 1
    p.sections.first.must_equal es
    I18n.locale = 'ca'
    p.sections.size.must_equal 1
    p.sections.first.must_equal es
    I18n.locale = original_locale
  end

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

