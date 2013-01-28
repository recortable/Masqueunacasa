# encoding: utf-8
require 'test_helper'

describe 'Application integration' do
  it 'adds the locale when visiting the home page' do
    visit "/"
    current_path.must_equal "/#{I18n.default_locale}/"
  end

  it 'adds the locale when visiting some page' do
    proposal = create(:proposal)
    visit "/habitapedia/propuestas/#{proposal.slug}"
    current_path.must_include "/#{I18n.default_locale}/"
  end
end