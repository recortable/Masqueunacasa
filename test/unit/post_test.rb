require 'test_helper'

describe Post do
  it 'create versions' do
    post = create(:post)
    post.versions.count.must_equal 1
    v = post.versions.first
    v.title.must_equal post.title
    v.group_id.must_equal post.group_id
  end
end
