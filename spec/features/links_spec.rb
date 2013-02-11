require 'spec_helper'

describe "Links integration", require_main_group: true do
  it "create link for experiencies" do
    create_link_probe create(:experiencie)
  end

  it 'create links for proposals' do
    create_link_probe create(:proposal)
  end

  it 'updates links for experiencies' do
    update_link_probe(create(:experiencie))
  end

  it 'updates links for proposals' do
    update_link_probe(create(:proposal))
  end

  it 'delete links from experiencies' do
    delete_link_probe(create(:experiencie))
  end

  it 'delete links from proposals' do
    delete_link_probe(create(:experiencie))
  end

  def create_link_probe(model)
    user = login_user( create(:user) )

    visit polymorphic_path( [:new, model, :link] )

    fill_in 'link_title', with: 'some title'
    fill_in 'link_url', with: 'http://mquc.org'
    click_submit

    expect( model.links.count).to eq 1
    link = model.links.first
    expect( link.document ).to eq model
    expect( link.title ).to eq 'some title'
    expect( link.url ).to eq 'http://mquc.org'
    expect( link.user ).to eq user
  end

  def update_link_probe(model)
    login_user( create(:user) )

    link = model.add_link( build(:link), model.user )
    visit polymorphic_path( [:edit, model, link] )

    fill_in 'link_title', with: 'new title'
    fill_in 'link_url', with: 'http://newurl.com'
    click_submit

    link.reload
    expect( link.title).to eq 'new title'
    expect( link.url ).to eq 'http://newurl.com'
  end

  def delete_link_probe(model)
    user = login_user( create(:user) )
    link = model.add_link( build(:link), user )

    visit polymorphic_path(model, only_path: true)

    f_link("delete-link-#{link.id} nofollow").click
    expect( model.links.count ).to eq 0
  end
end
