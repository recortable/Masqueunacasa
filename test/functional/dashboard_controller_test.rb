require 'test_helper'

describe 'Dashboard integration' do
  it 'should be visible' do
    visit root_path
  end

  it 'lists recent post of all groups' do
    p1 = create(:post)
    p2 = create(:post)
    visit community_path
    page.text.must_include p1.title
    page.text.must_include p2.title
  end
end
