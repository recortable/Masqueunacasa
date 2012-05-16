require 'test_helper'

describe 'Phases integration' do

  it 'list phases' do
    phase = create(:phase)
    visit phases_path
    page.text.must_include phase.name
    page.text.must_include phase.description
  end

  it 'can create phases' do
    login_user create(:user, admin: true)
    visit phases_path
    page.find("a[rel='new-phase']")
  end

  it 'creates phases' do
    login_user create(:user, admin: true)
    visit new_phase_path
    fill_in 'phase_name_es', with: 'Nombre'
    fill_in 'phase_name_ca', with: 'Nom'
    click_submit
    phase = Phase.last
    phase.name_es.must_equal 'Nombre'
    phase.name_ca.must_equal 'Nom'
  end

  it 'can edit phases' do
    login_user create(:user, admin: true)
    phase = create(:phase)
    visit phases_path
    page.find("a[rel='edit-phase-#{phase.id}']")
  end

  it 'updates phases' do
    login_user create(:user, admin: true)
    phase = create(:phase)
    visit edit_phase_path(phase)
    fill_in 'phase_name_es', with: 'Nombre editado'
    fill_in 'phase_name_ca', with: 'Nom editado'
    click_submit
    phase.reload
    phase.name_es.must_equal 'Nombre editado'
    phase.name_ca.must_equal 'Nom editado'
  end
end
