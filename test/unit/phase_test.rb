require 'test_helper'

describe Phase do
  it "has position" do
    c = create(:phase)
    c.position.must_equal 1
    c = create(:phase)
    c.position.must_equal 2
  end
end
