require 'test_helper'

describe Image do
  it "title is required" do
    img = build(:image, title: nil)
    img.save.must_equal false
  end
  
  it "image or external is required, but no both" do
    i = build(:image, external_image_url: 'a', image: nil)
    i.save.must_equal true

    i = build(:image, external_image_url: nil, image: 'a')
    i.valid?
    puts i.errors.inspect
    i.save.must_equal true

    i = build(:image, external_image_url: 'a', image: 'b')
    i.save.must_equal false
  end
end
