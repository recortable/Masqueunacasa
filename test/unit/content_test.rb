require 'test_helper'

describe Content do

  it "has title" do
    content = create(:content)
    content.title.must_be :present?
  end

  it "always have published at" do
    content = create(:content, published_at: nil)
    content.published_at.must_be :present?
  end
end
