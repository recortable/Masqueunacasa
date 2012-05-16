require 'test_helper'

describe Post do
  it 'create versions' do
    post = create(:post)
    Version.count.must_equal 1
    v = Version.last
    v.title.must_equal post.title
    v.group_id.must_equal post.group_id
  end
end
