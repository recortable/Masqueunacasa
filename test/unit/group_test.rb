require 'test_helper'

describe Group do
  it "is not a site" do
    create(:group).site?.must_equal false
  end

  it 'has recipients' do
    group = create(:group)
    owner = group.user
    member = create(:user)
    group.add_member(member)

    all = group.recipients
    all.size.must_equal 2
    [owner, member].each {|u| all.must_include u }
  end
end
