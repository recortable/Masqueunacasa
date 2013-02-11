# encoding: utf-8
require "spec_helper"

describe "Categories integration", require_main_group: true do
  let(:cat) { create( :category ) }

  it "show category" do
    visit category_path( cat )
    expect( page ).to have_content cat.title
  end

  it "shows category proposals" do
    p = FactoryGirl.create( :proposal, category: cat )
    1.upto(3) { p.add_relation( create(:experiencie), cat.user ) }
    visit category_path(cat)
    expect( page ).to have_content p.title
    expect( page ).to have_content p.summary
    expect( page ).to have_content p.experiencies_count.to_s
  end

  it "can create proposals inside a category" do
    login_user create(:user)
    visit category_path(cat)
    f_link 'new-proposal'
  end

  it "creates categories" do
    f = FactoryGirl.create( :phase )
    user = FactoryGirl.create( :user, admin: true )

    login_user(user)
    visit new_phase_category_path(f)
    fill_in 'category_name', with: 'Mi categoría'
    fill_in 'category_title', with: '¿Qué hacemos?'
    fill_in 'category_summary', with: 'Las cositas'
    click_submit

    category = Category.last
    expect( category.phase).to eq f
    expect( category.user).to eq user
    expect( category.name ).to eq'Mi categoría'
    expect( category.title ).to eq '¿Qué hacemos?'
    expect( category.summary ).to eq 'Las cositas'
  end
end
