require 'spec_helper'

describe "Sections integration", require_main_group: true do
  let( :user ) { create :user }

  it "proposals displys sections" do
    doc =  FactoryGirl.create( :proposal )
    section = doc.add_section( build(:section), user )

    visit polymorphic_path(doc)
    expect( page ).to have_content section.body
  end

  it "create section for proposal" do
    login_user user
    doc = FactoryGirl.create( :proposal )

    visit polymorphic_path(doc)
    f_link('new-section').click

    fill_in 'section_title', with: 'title'
    fill_in 'section_body', with: 'section body'
    click_submit

    expect( doc.sections.count).to eq 1
    section = doc.sections.first
    expect( section.title ).to eq 'title'
    expect( section.body ).to eq 'section body'
    expect( doc.editor?(user) ).to eq true
  end
end
