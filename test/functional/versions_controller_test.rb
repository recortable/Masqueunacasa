require 'test_helper'

describe 'Versions integration' do
  it 'list versions' do
    post = create(:post)
    v = Version.last
    visit versions_path
    page.text.must_include v.title
  end
end
