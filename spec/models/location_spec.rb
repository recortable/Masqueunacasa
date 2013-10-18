# encoding: utf-8
require 'spec_helper'

describe Location do
  let(:location) { create :location }
  let(:exp_location) { create :exp_location }

  it "destroy location when destroying resource" do
    location.resource.destroy
    expect(Location.all.include? location).to be_false
  end

  it "destroy location when destroying resource (experiencie)" do
    exp_location.resource.destroy
    expect(Location.all.include? exp_location).to be_false
  end

  it "destroy location when destroying resource (user)" do
    user = create(:user)
    loc = create(:location, resource: user)
    user.destroy
    expect(Location.all.include? loc).to be_false
  end
end
