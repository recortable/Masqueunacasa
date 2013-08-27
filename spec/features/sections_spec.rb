require 'spec_helper'

shared_examples_for "Adding sections" do |describing, url, fields_to_fill, nested_under|
  let( :user ) { login_user create( :user, admin: true ) }
  let( :url_arg ) { create nested_under if nested_under }
  let( :url_path ) { send url, url_arg }

  it "can add section fields in forms" do
    user
    visit url_path

    click_on I18n.t('app.add', element: TextSection.model_name.human)
    expect( page ).to have_css('fieldset .fields textarea', count: 1)

    click_on I18n.t('app.add', element: ImageSection.model_name.human)
    expect( page ).to have_css('fieldset .fields input.file', count: 1)
  end

  it "text sections presist" do
    user
    visit url_path
    fields_to_fill.each do |field|
      fill_in "#{describing}_#{field}", with: "The #{describing} #{field}"
    end
    click_on I18n.t('app.add', element: TextSection.model_name.human)
    section = page.find('fieldset.sections .fields')
    section.fill_in I18n.t('simple_form.labels.defaults.title'), with: "Section 1 title"
    section.fill_in I18n.t('simple_form.labels.defaults.body'), with: "Section 1 text"
    find('#commit-form').click
    expect( page ).to have_content "Section 1 title"
    expect( page ).to have_content "Section 1 text"
  end
end

describe "Experience sections", js: true do
  it_behaves_like "Adding sections", :experiencie, :new_experiencie_path, %w(title summary)
end

describe "Proposal sections", js: true do
  it_behaves_like "Adding sections", :proposal, :new_category_proposal_path, %w(title summary), :category
end

#describe "Category sections", js: true do
  #it_behaves_like "Adding sections", :category, :new_category_path, %w(title name summary)
#end
