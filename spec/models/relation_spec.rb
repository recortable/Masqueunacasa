require 'spec_helper'

describe Relation do
  let( :relation ) { create :relation }

  it "has phase and category" do
    expect( relation.phase ).to eq( relation.proposal.phase )
    expect( relation.category ).to eq( relation.proposal.category )
  end
end
