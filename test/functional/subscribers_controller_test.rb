require 'test_helper'

describe 'SubscribersController integration' do
  it 'proposal can be subscribed' do
    user = create(:user)
    login_user user

    doc = create(:proposal)
    visit polymorphic_path(doc)
    find_link('follow-document nofollow').click
    doc.subscribers.count.must_equal 1
    doc.subscriptors.must_include user
  end
end
