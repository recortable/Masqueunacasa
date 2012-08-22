require 'test_helper'

describe HasEditors do
  it 'find editorship of user' do
    user = create(:user)
    document = create(:proposal)
    document.editorship_of(user).must_be :blank?
  end

  it 'add editorship on category creation' do
    User.current_user = create(:user)
    category = create(:category)
    category.editors.must_include User.current_user
  end

  it 'add editorship on category update' do
    category = create(:category)
    User.current_user = create(:user)
    category.title = 'New category title'
    category.save
    category.editors.must_include User.current_user
  end

end
