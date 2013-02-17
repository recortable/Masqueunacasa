require 'spec_helper'

describe "Phases integration" do
  let( :group ) { create :group, admin: true }
  let( :phase ) { create :phase }

  subject { page }

  it "list phases" do
    phase
    visit phases_path
    should have_content phase.title
    should have_content phase.summary
  end

  it "show phases and its categories" do
    c1 = FactoryGirl.create( :category, phase: phase )
    visit phases_path
    should have_text c1.title
  end

  it "creates phases" do
    login_user create( :user, admin: true )
    visit new_phase_path
    fill_in 'phase_title', with: 'Nombre'
    click_submit
    new_phase = Phase.last
    expect( new_phase.title ).to eq 'Nombre'
    visit phases_path
    should have_text new_phase.title
  end

  it "can edit a phase" do
    login_user create( :user, admin: true )
    phase
    visit phases_path
    find_action_link! "edit-phase-#{phase.id}"
  end

  it "update a phase" do
    login_user create( :user, admin: true )
    visit edit_phase_path(phase)
    fill_in 'phase_title', with: 'Nombre editado'
    click_submit
    should have_content "Nombre editado"
  end
end

