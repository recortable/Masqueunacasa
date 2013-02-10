require 'spec_helper'

describe Relation do
  it "has phase and category" do
    p = FactoryGirl.create( :proposal )
    e = FactoryGirl.create( :experiencie )
    u = FactoryGirl.create( :user )

    r = Relation.create( proposal: p, experiencie: e, user: u )
    expect( r.phase ).to eq( p.phase )
    expect( r.category ).to eq( p.category )
  end
end
