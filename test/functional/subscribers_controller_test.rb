require 'test_helper'

describe 'Subscribers integration' do
  it 'category can be subscribed' do
    #subscribe_probe(create(:category))
  end

  it 'proposal can be subscribed' do
    #subscribe_probe(create(:proposal))
  end

  it 'experiencies can be subscribed' do
    #subscribe_probe(create(:experiencie))
  end

  def subscribe_probe(doc, url = nil)
    user = create(:user)
    login_user user

    url ||= [:edit, doc]

    visit polymorphic_path(url)
    follow_link = find_action_link('follow-document')
    follow_link.click

    doc.subscribers.count.must_equal 1
    doc.subscriptors.must_include user
  end
end
