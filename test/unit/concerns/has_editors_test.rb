require 'test_helper'

describe HasEditors do
  it 'find edited of user' do
    user = create(:user)
    document = create(:proposal)
    document.edited(user).must_be :blank?
  end
end
