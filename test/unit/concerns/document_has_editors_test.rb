require 'test_helper'

describe DocumentHasEditors do
  it 'adds editorship when create section' do
    document = create(:category)
    User.current_user = create(:user)
    section = create(:section, document: document)
    document.editors.must_include User.current_user
  end

  it 'adds editorship when update a section' do
    document = create(:category)
    section = create(:section, document: document)
    User.current_user = create(:user)
    section.title = 'New title'
    section.save
    document.editors.must_include User.current_user
  end

  it 'doesnt add editorship if updating a section of a group' do
    group = create(:group)
    section = create(:section, document: group)
    section.title = 'The group'
    section.save
  end
end
