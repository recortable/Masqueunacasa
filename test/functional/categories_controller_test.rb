# encoding: utf-8
require 'test_helper'

describe 'Categories integration' do
  it 'creates categories' do
    phase = create(:phase)
    user = create(:user, admin: true)

    login_user(user)
    visit new_phase_category_path(phase)
    fill_in 'category_title', with: 'Mi categoría'
    fill_in 'category_question', with: '¿Qué hacemos?'
    fill_in 'category_body', with: 'Las cositas'
    click_submit
    category = Category.last
    category.phase.must_equal phase
    category.user.must_equal user
    category.title.must_equal 'Mi categoría'
    category.question.must_equal '¿Qué hacemos?'
    category.body.must_equal 'Las cositas'
  end
end
