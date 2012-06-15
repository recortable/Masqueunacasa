require 'test_helper'

describe 'Posts integration' do
  it 'list posts of a group' do
    group = create(:group)
    post = create(:post, group: group)
    other = create(:post)
    subdomain group.subdomain
    visit root_path
    page.text.must_include post.title
    page.text.wont_include other.title
  end

  it 'creates a post from a group' do
    user = create(:user)
    group = create(:group)
    group.add_member(user)
    login_user(user)

    subdomain(group.subdomain)
    visit new_post_path
    fill_in 'post_title', with: 'First post'
    fill_in 'post_body', with: 'Post body'
    click_submit
    post = group.posts.last
    post.title.must_equal 'First post'
    post.body.must_equal 'Post body'
  end

  it 'member can create posts' do
    group = create(:group)
    user = create(:user)
    group.add_member(user)

    login_user(user)
    subdomain(group.subdomain)
    visit root_path
    page.find('a[rel="new-post"]').click
    page.current_path.must_equal new_post_path
  end
end
