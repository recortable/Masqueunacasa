require 'test_helper'

describe Content do

  it "has title" do
    content = create(:content)
    content.title.must_be :present?
  end
end
