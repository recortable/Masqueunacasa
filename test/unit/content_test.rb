require 'test_helper'

describe Content do
  let(:content) { create(:content) }

  it "has title" do
    content.title.must_be :present?

    content.title = ""
    content.wont_be :valid?
  end

  it "always have published at" do
    content = create(:content, published_at: nil)
    content.published_at.must_be :present?
  end

  it "has original locale" do
    content.original_locale.must_equal I18n.locale
  end
end
