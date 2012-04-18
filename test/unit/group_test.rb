require 'test_helper'

describe Group do
  it "can't have same name as a user" do
    user = create(:user, name: 'some name')
    group = build(:group, name: 'some name')
    group.save.must_equal false
    group.name = 'other name'
    group.save.must_equal true
  end
end
