require 'spec_helper'

describe Phase do
  let( :f ) { create( :phase ) }
  it "has position" do
    expect( f.position ).to eq( 1 )
    otra_f = FactoryGirl.create( :phase )
    expect( otra_f.position ).to eq( 2 )
  end
end
