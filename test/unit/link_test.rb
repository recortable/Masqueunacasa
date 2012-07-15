# encoding: utf-8
require 'test_helper'

describe Link do
  it 'sin título, el título es la url' do
    link = build(:link, title: nil)
    link.save.must_equal true
    link.title.must_equal link.url
  end

  it 'content_type is link by default' do
    link = create(:link)
    link.content_type.must_equal 'link'
  end

  it 'content_type is video if video link' do
    link = create(:link, url: 'http://youtube.com/fsdfsdf')
    link.content_type.must_equal 'video'
  end
end
