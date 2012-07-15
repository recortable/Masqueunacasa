require 'test_helper'

describe "LinksController integration" do
  it 'create links for experiencies' do
  
    e = create(:experiencie)
    visit new_experiencie_link_path(e)
    fill_in 'link_title', with: 'exp1'
    fill_in 'link_url', with: 'http://mquc.org'
    click_submit

    e.links.count.must_equal 1
    link = e.links.first
    link.title.must_equal 'exp1'
    link.url.must_equal 'http://mquc.org'
  end

end
