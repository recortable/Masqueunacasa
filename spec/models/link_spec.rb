# encoding: utf-8
require 'spec_helper'

describe Link do
  let( :link ) { create( :link, title: 'title' ) }

  it "con título, el caption es el título" do
    expect( link.caption ).to eq( link.title )
  end

  it "sin título, el caption es la url" do
    link.update_attributes( title: nil )
    link.reload
    expect( link.caption ).to eq( link.url )
  end

  it "content type is link by default" do
    expect( link.content_type ).to eq( 'link' )
  end

  it "content_type is video if video link" do
    new_link = FactoryGirl.create( :link, url: 'http://youtube.com/asdgfgr' )
    expect( new_link.content_type ).to eq( 'video' )
  end
end
