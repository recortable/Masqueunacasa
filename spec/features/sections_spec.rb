require 'spec_helper'

describe "Sections integration", js: true do
  let( :user ) { login_user create( :user ) }

  context "Experiencies" do

    it "can add section fields in forms" do
      user
      visit new_experiencie_path
      click_on "Add text section"
      expect( page ).to have_css('fieldset .fields textarea', count: 1)
      click_on "Add text section"
      expect( page ).to have_css('fieldset .fields textarea', count: 2)
      click_on "Add image section"
      expect( page ).to have_css('fieldset .fields input.file', count: 1)
    end
  end
end
