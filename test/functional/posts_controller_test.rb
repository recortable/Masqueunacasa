require 'test_helper'

describe 'Posts integration' do
  it 'list posts of a group' do
    group = setup_group

    post = create(:post, group: group)
    other = create(:post)
    visit posts_path
    page.text.must_include post.title
    page.text.wont_include other.title
  end

  it 'creates a post' do
    group = setup_group

    visit new_post_path
    fill_in 'post_title', with: 'First post'
    fill_in 'post_body', with: 'Post body'
    click_submit

    post = group.posts.last
    post.title.must_equal 'First post'
    post.body.must_equal 'Post body'
  end

  it 'can create posts if member' do
    group = setup_group

    visit posts_path
    page.find('a[rel="new-post"]').click
    page.current_path.must_equal new_post_path
  end
end
