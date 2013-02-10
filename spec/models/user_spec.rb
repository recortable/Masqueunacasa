require 'spec_helper'

describe User do
  let( :user ) { create( :user ) }
  subject { user }

  it { should be_valid }

  it "requires name" do
    user.name = ""
    should_not be_valid
  end

  it "requires email" do
    user.email = ""
    should_not be_valid
  end

  it "requires password and password confirmation" do
    u = FactoryGirl.build( :user, password: "", password_confirmation: "" )
    expect( u ).to_not be_valid
  end
end
