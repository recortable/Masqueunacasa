require 'spec_helper'

describe Section do
  let( :proposal ) { create( :proposal ) }
  let( :exp ) { create( :experiencie ) }

  it "has document title" do
    s = FactoryGirl.create( :section, document: proposal )
    expect( s.document_title ).to eq( proposal.title )
  end

  it "has position" do
    expect( create( :section, document: proposal ).position ).to eq( 1 )
    expect( create( :section, document: proposal ).position ).to eq( 2 )
    expect( create( :section, document: exp ).position ).to eq( 1 )
    expect( create( :section, document: exp ).position ).to eq( 2 )
  end

  it "touches document" do
    date = proposal.updated_at
    create( :section, document: proposal )
    expect( proposal.updated_at).to_not eq( date )
  end
end
