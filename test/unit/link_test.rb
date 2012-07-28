# encoding: utf-8
require 'test_helper'

describe Link do
  it 'con título, el caption es el título' do
    link = create(:link, title: 'title')
    link.caption.must_equal link.title
  end

  it 'sin título, el caption es la url' do
    link = build(:link, title: nil)
    link.save.must_equal true
    link.caption.must_equal link.url
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
