require 'spec_helper'

describe "Phases integration" do
  let( :group ) { create :group, admin: true }
  let( :phase ) { create :phase }

  subject { page }

  it "show phases and its categories" do
    c1 = FactoryGirl.create( :category, phase: phase )
    visit phases_path
    should have_text c1.title
  end
end

