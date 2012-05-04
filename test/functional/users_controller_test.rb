require 'test_helper'

describe 'Users integration' do
  it 'list users' do
    user = create(:user)
    visit users_path
    page.text.must_include user.name
  end
end
