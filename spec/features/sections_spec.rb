require 'spec_helper'

describe "Sections integration", require_main_group: true do
  let( :user ) { create :user }

  it "proposals display sections" #do
    #doc =  FactoryGirl.create( :proposal )
    #section = doc.add_section( build(:section), user )

    #visit polymorphic_path(doc)
    #expect( page ).to have_content section.body
  #end
end
