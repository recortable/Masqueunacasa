require 'spec_helper'

shared_examples_for "track" do |resource_type|

  let(:user) { login_user create(:user) }
  let(:admin) { login_user create(:user, admin: true) }
  let(:resource) { create(resource_type) }

  it "creation" do
    user
    visit send("new_#{resource_type}_path")
    title = "The #{resource_type} title"
    summary = "The #{resource_type} summary"
    fill_in "#{resource_type}_title", with: title
    fill_in "#{resource_type}_summary", with: summary
    click_submit
    expect( trackable.title ).to eq(title)
    expect( trackable.summary ).to eq(summary)
  end

  it "update" do
    user
    visit send("edit_#{resource_type}_path", resource)
    title = "The #{resource_type} updated title"
    summary = "The #{resource_type} updated summary"
    fill_in "#{resource_type}_title", with: title
    fill_in "#{resource_type}_summary", with: summary
    click_submit
    expect( trackable.title ).to eq(title)
    expect( trackable.summary ).to eq(summary)
  end

  it "translation" do
    user
    resource
    locale = T.avl.reject { |l| l == T.dfl }.first
    visit T.w_l(locale) { send("edit_#{resource_type}_path", resource) }

    expect( resource.translated_to?(locale) ).not_to be_true

    title = "The #{resource_type} translated title"
    summary = "The #{resource_type} translated summary"
    fill_in "#{resource_type}_title", with: title
    fill_in "#{resource_type}_summary", with: summary
    click_submit
    expect( last_activity.key ).to eq("#{resource_type}.translate")
    expect( trackable.title ).to eq(title)
    expect( trackable.summary ).to eq(summary)
  end

  it "destroy" do
    admin
    resource
    visit send("#{resource_type}_path", resource)
    click_link "Borrar"
    expect( last_activity.key ).to eq("#{resource_type}.destroy")
  end

  def last_activity
    PublicActivity::Activity.order("created_at DESC").first
  end

  def trackable
    last_activity.try('trackable')
  end
end

describe "Experiencies activities" do
  it_behaves_like "track", 'experiencie'
end

