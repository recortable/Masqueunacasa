require 'test_helper'

describe "LinksController integration" do
  it 'create links for experiencies' do
    create_link_probe(create(:experiencie))
  end

  it 'create links for proposals' do
    create_link_probe(create(:proposal))
  end

  it 'delete links from experiencies' do
    delete_link_probe(create(:experiencie))
  end

  it 'delete links from proposals' do
    delete_link_probe(create(:experiencie))
  end

  def create_link_probe(model)
    user = create(:user)
    login_user user

    visit polymorphic_path([:new, model, :link])

    fill_in 'link_title', with: 'some title'
    fill_in 'link_url', with: 'http://mquc.org'
    click_submit

    model.links.count.must_equal 1
    link = model.links.first
    link.title.must_equal 'some title'
    link.url.must_equal 'http://mquc.org'
    link.user.must_equal user
  end

  def delete_link_probe(model)
    user = create(:user)
    login_user user
    link = model.add_link(build(:link), user)

    visit polymorphic_path(model, only_path: true)

    find_link("delete-link-#{link.id} nofollow").click
    model.links.count.must_equal 0

  end
end
