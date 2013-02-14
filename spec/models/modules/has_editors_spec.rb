require 'spec_helper'

describe HasEditors do
  let( :user ) { create( :user ) }

  it "find editorship for user" do
    document = FactoryGirl.create( :proposal )
    expect( document.editorship_of(user) ).to be_nil
  end

  it "adds editorship whe users creates a category" do
    User.current_user = user
    cat = FactoryGirl.create( :category )
    expect( cat.editors ).to include user
  end

  it "adds editorship on category updates" do
    cat = FactoryGirl.create( :category )
    User.current_user = FactoryGirl.create( :user )
    cat.update_attributes title: "New category title"
    expect( cat.editors ).to include User.current_user
  end
end
