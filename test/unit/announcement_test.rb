require 'test_helper'

describe Announcement do
  it "is not sent by default" do
    create(:announcement).sent?.must_equal false
  end

  it "default scope is 'all'" do
    a = build(:announcement)
    a.scope.must_be :blank?
    a.save
    a.scope.must_equal 'all'
  end
end
