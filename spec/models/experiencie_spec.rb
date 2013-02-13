# encoding: utf-8
require 'spec_helper'

describe Experiencie do
  let( :exp ) { create( :experiencie ) }

  it 'title is unique' do
    another_exp = FactoryGirl.build( :experiencie, title: exp.title )
    expect( another_exp ).to_not be_valid
  end

  describe "searching by title" do
    let( :exp1 ) { create( :experiencie, title: "Esto es una prueba" ) }
    let( :exp2 ) { create( :experiencie, title: "Esto es otra prueba" ) }
    let( :exp3 ) { create( :experiencie, title: "No debería encontrarlo" ) }
    results = Experiencie.search( 'prueba' )

    it "return matching experiencies sorted by title" do
      exp1; exp2; exp3;
      expect( results ).to eq( [exp2, exp1] )
    end

    it "should not return non-matching experiencies" do
      exp1; exp2; exp3;
      expect( results ).to_not be_empty
      expect( results ).to_not include exp3
    end
  end

  context "proposals counter" do
    let( :p1 ) { create( :proposal ) }

    it "sums 1 when adding a preposal" do
      p1.add_relation( exp, p1.user )
      exp.reload
      expect( exp.proposals_count ).to eq( 1 )
    end

    it "substract 1 when deleting a proposal" do
      p1.destroy
      exp.reload
      expect( exp.proposals_count ).to eq( 0 )
    end
  end
end
