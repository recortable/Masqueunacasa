require 'spec_helper'

describe "Dashboard integration", require_main_group: true do
  it "root should be visible" do
    visit root_path
  end

  it "shows communities dashboard" do
    visit community_path
  end
end
