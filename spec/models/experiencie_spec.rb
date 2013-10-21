# encoding: utf-8
require 'spec_helper'

describe Experiencie do
  let( :exp ) { create( :experiencie ) }

  it 'title is unique' do
    another_exp = FactoryGirl.build( :experiencie, title: exp.title )
    expect( another_exp ).to_not be_valid
  end

  context "proposals counter" do
    it "sums 1 when adding a preposal" do
      expect{ create :relation, experiencie: exp }.to change{ exp.reload.proposals_count }.
        from(0).to(1)
    end

    it "substract 1 when deleting a proposal" do
      relation = create(:relation, experiencie: exp)
      expect{ relation.proposal.destroy }.to change{ exp.reload.proposals_count }.
        from(1).to(0)
    end
  end
end

