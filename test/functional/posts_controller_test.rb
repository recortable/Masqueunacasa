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

  it 'creates a post from a group' do
    user = create(:user)
    group = create(:group)
    group.add_member(user)
    login_user(user)

    subdomain(group.slug)
    visit new_post_path
    fill_in 'post_title', with: 'First post'
    fill_in 'post_body', with: 'Post body'
    click_submit
    post = group.posts.last
    post.title.must_equal 'First post'
    post.body.must_equal 'Post body'
  end
end
