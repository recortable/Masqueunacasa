require 'spec_helper'

describe DocumentHasEditors do
  let( :doc ) { create( :category ) }
  let( :user ) { create( :user) }

  before do
    User.current_user = user
    create( :section, document: doc )
  end

  it "adds aditorship when a user creates a section" do
    expect( doc.editors ).to include user
  end

  it "adds editorship if another user update a section" do
    section = FactoryGirl.create( :section, document: doc )
    new_user = FactoryGirl.create( :user)
    User.current_user = new_user
    create( :section, document: doc )
    expect( doc.editors ).to include new_user
  end

  it "groups doesn't have editors" do
    group = FactoryGirl.create( :group )
    expect { group }.to_not respond_to :editors
  end
end
