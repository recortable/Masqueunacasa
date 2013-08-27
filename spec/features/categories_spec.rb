# encoding: utf-8
require "spec_helper"

describe "Categories integration" do
  let(:cat) { create( :category ) }

  it "show category" do
    visit category_path( cat )
    expect( page ).to have_content cat.title
  end

  it "shows category proposals" do
    p = FactoryGirl.create( :proposal, category: cat )
    visit category_path(cat)
    expect( page ).to have_content p.title
  end
end
