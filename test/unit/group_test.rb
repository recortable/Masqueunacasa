require 'test_helper'

describe Group do
  it "is not a site" do
    create(:group).site?.must_equal false
  end
end
