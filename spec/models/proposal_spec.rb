require 'spec_helper'

describe Proposal do
  let( :proposal ) do
    create( :proposal ,
           user: create( :user ),
           category: create( :category )
          )
  end

  it "creates slugs for all available langs" do
    T.avl.each do |l|
      expect( proposal.send( "slug_#{l}").present? ).to be_true
    end
  end

  it "scopes by published" do
    proposal.update_attributes published: true
    hidden = FactoryGirl.create( :proposal, published: false )
    expect( Proposal.published.count ).to eq( 1 )
    expect( Proposal.published.first ).to eq( proposal )
  end

  it "it can be related to a experience" do
    exp = create(:experiencie)
    FactoryGirl.create(:relation, proposal: proposal, experiencie: exp)
    expect( proposal.relations.count ).to eq( 1 )
    expect( proposal.experiencies.first ).to eq( exp )
  end

  it "has experiencies counter" do
    expect{ create :relation, proposal: proposal }.to change{ proposal.reload.experiencies_count }.
      from(0).to(1)
  end
end
