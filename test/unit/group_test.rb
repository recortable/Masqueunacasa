require 'test_helper'

describe Group do
  it "is not a site" do
    create(:group).site?.must_equal false
  end

  it "is not closed by default" do
    closed = create(:group, closed: true)
    closed.closed?.must_equal true
    group = create(:group).closed?.must_equal false
  end
end
