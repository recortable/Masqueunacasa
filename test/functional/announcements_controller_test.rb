require 'test_helper'

describe 'Announcements integration' do
  it 'list announcements' do
    user = create(:user)
    group = create(:group)
    group.add_member(user)
    ann = create(:announcement, group: group)

  end
end
