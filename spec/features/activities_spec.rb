require 'spec_helper'

shared_examples_for "track" do |resource_type|

  let(:user) { login_user create(:user) }
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
    locale = T.avl.reject { |l| l == T.dfl }.first
    visit T.w_l(locale) { send("edit_#{resource_type}_path", resource) }
    title = "The #{resource_type} translated title"
    summary = "The #{resource_type} translated summary"
    fill_in "#{resource_type}_title", with: title
    fill_in "#{resource_type}_summary", with: summary
    click_submit
    expect( last_activity.key ).to eq("#{resource_type}.translate")
    expect( trackable.title ).to eq(title)
    expect( trackable.summary ).to eq(summary)
  end

  it "only if resource have changes"#do
    #ActiveRecord::Base.connection().execute("delete from activities")
    #user

    #visit send("edit_#{resource_type}_path", resource)
    #click_button "commit"
    #expect( trackable ).not_to eq(resource)
  #end

  def last_activity
    PublicActivity::Activity.order("created_at DESC").first
  end

  def trackable
    last_activity.trackable
  end
end

describe "Experiencies activities" do
  it_behaves_like "track", 'experiencie'
end

