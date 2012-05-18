require 'test_helper'

describe 'Pages integration' do
  it 'list pages of a group' do
    group = create(:group)
    a_page = create(:page, group: group)
    other = create(:page)
    subdomain group.subdomain
    visit pages_path
    page.text.must_include a_page.title
    page.text.wont_include other.title
  end

  it 'creates a page from a group' do
    user = create(:user)
    group = create(:group)
    group.add_member(user)
    login_user(user)

    subdomain(group.subdomain)
    visit new_page_path
    fill_in 'page_title', with: 'First page'
    fill_in 'page_body', with: 'Page body'
    click_submit
    the_page = group.pages.last
    the_page.title.must_equal 'First page'
    the_page.body.must_equal 'Page body'
  end

  it 'member can create pages' do
    group = create(:group)
    user = create(:user)
    group.add_member(user)

    login_user(user)
    subdomain(group.subdomain)
    visit pages_path
    page.find('a[rel="new-page"]').click
    page.current_path.must_equal new_page_path
  end
end
