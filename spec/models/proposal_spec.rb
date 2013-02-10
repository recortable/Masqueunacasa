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
    user = FactoryGirl.create( :user )
    exp = FactoryGirl.create( :experiencie )
    proposal.add_relation( exp, user )
    expect( proposal.relations.count ).to eq( 1 )
    expect( proposal.experiencies.first ).to eq( exp )
  end

  it "has experiencies counter" do
    proposal.add_relation( create( :experiencie ), proposal.user )
    proposal.add_relation( create( :experiencie ), proposal.user )
    proposal.reload
    expect( proposal.experiencies_count ).to eq( 2 )
  end
end
