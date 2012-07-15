require 'test_helper'

describe 'SectionsController integration' do
  it 'proposals displays sections' do
    document = create(:proposal)
    section = document.add_section(build(:section), create(:user))

    visit polymorphic_path(document)
    page.text.must_include section.body
  end

  it 'create section for proposal' do
    user = create(:user)
    login_user user
    document = create(:proposal)

    visit polymorphic_path(document)
    find_link('new-section').click

    fill_in 'section_title', with: 'title'
    fill_in 'section_body', with: 'section body'
    click_submit

    document.sections.count.must_equal 1
    section = document.sections.first
    section.title.must_equal 'title'
    section.body.must_equal 'section body'
    document.editor?(user).must_equal true
  end

end
