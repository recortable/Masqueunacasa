require 'test_helper'

describe Image do
  it "without title is not valid" do
    img = build(:image, title: nil)
    img.save.must_equal false
  end

  it "has image xor external image" do
    img = build(:image, external_image_url: nil)
    img.save.must_equal false

    img = build(:image)
    img.image = "some.jpeg"

    img.save.must_equal false
  end
end
