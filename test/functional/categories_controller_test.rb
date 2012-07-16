# encoding: utf-8
require 'test_helper'

describe 'Categories integration' do
  it 'show category and its proposals' do
    category = create(:category)
    p1 = create(:proposal, category: category)

    visit category_path(category)
    page.text.must_include category.question
  end

  it 'can create proposals inside category' do
    login_user create(:user)
    category = create(:category)
    login_user create(:user)
    visit category_path(category)
    find_link('new-proposal')
  end

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
