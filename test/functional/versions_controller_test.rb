require 'test_helper'

describe 'Versions integration' do
  it 'list versions' do
    post = create(:post)
    v = Version.last
    # the controller handles this
    v.update_attributes(user_name: 'UserName', whodunnit: 1) 
    visit versions_path
    page.text.must_include v.user_name
    page.text.must_include v.title
  end
end
