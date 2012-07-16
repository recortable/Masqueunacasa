require 'test_helper'

describe HasEditors do
  it 'find editorship of user' do
    user = create(:user)
    document = create(:proposal)
    document.editorship_of(user).must_be :blank?
  end
end
