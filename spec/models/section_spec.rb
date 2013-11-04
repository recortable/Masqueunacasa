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

  it "when destroying a document destroy its sections" do
    s = create(:section, document: proposal)
    s.document.destroy
    expect(Section.exists?(s)).to be_false
  end

  it "when destroying a document destroy its sections with all locales" do
    s = create(:section, document: proposal)
    T.l = :ca
    s.document.destroy
    expect(s.locale).not_to eq(T.l)
    expect(Section.exists?(s)).to be_false
  end

end

