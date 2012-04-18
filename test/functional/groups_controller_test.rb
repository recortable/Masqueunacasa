require 'test_helper'

describe 'Groups integration' do
  it 'list groups' do
    g1 = create(:group)
    g2 = create(:group)
    visit groups_path
    page.text.must_include g1.name
    page.text.must_include g2.name
  end
end
