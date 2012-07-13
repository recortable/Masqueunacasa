require 'test_helper'

describe 'Phases integration' do
  before do 
    create(:group, admin: true)
  end

  it 'list phases' do
    phase = create(:phase)
    visit phases_path
    page.text.must_include phase.title
  end

  it 'creates phases' do
    login_user create(:user, admin: true)
    visit new_phase_path
    fill_in 'phase_title_es', with: 'Nombre'
    fill_in 'phase_title_ca', with: 'Nom'
    click_submit
    phase = Phase.last
    phase.title_es.must_equal 'Nombre'
    phase.title_ca.must_equal 'Nom'
  end

  it 'can edit phase' do
    login_user create(:user, admin: true)
    phase = create(:phase)
    visit phase_path(phase)
    find_link "edit-phase-#{phase.id}"
  end

  it 'update a phase' do
    login_user create(:user, admin: true)
    phase = create(:phase)
    visit edit_phase_path(phase)
    fill_in 'phase_title_es', with: 'Nombre editado'
    fill_in 'phase_title_ca', with: 'Nom editado'
    click_submit
    phase.reload
    phase.title_es.must_equal 'Nombre editado'
    phase.title_ca.must_equal 'Nom editado'
  end
end
