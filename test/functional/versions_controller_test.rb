require 'test_helper'

describe 'Versions integration' do
  it 'list versions' do
    post = create(:post)
    v = Version.last
    v.update_attribute(:user_name, 'UserName') # the controller handles this
    visit versions_path
    page.text.must_include v.user_name
    page.text.must_include v.title
  end
end
