require 'test_helper'

describe "LinksController integration" do
  it 'create links for experiencies' do
    document = create(:experiencie)
  end

  def create_link_probe(document)
    visit polymorphic_path([:new, document, :link])
    fill_in 'link_title', with: 'title'
    fill_in 'link_url', with: 'http://mquc.org'
    click_submit

    document.links.count.must_equal 1
    link = document.links.first
    link.title.must_equal 'title'
    link.url.must_equal 'http://mquc.org'
  end

end
