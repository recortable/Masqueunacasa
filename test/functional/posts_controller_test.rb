require 'test_helper'

describe 'Posts integration' do
  it 'list posts of a group' do
    group = create(:group)
    post = create(:post, group: group)
    other = create(:post)
    subdomain group.slug
    visit posts_path
    page.text.must_include post.title
    page.text.wont_include other.title
  end

  it 'lists recent post of all groups' do
    p1 = create(:post)
    p2 = create(:post)
    visit posts_path
    page.text.must_include p1.title
    page.text.must_include p2.title
  end
end
