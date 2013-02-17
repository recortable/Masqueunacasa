require 'spec_helper'

describe "Dashboard integration" do
  it "root should be visible" do
    visit root_path
  end
end
