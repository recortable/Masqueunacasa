require 'test_helper'

describe 'Subscribers integration' do
  it 'category can be subscribed' do
    user = create(:user)
    login_user user
    category = create(:category)
    visit polymorphic_path([category.phase, category])
    find_link('follow-document nofollow').click

  end

  it 'proposal can be subscribed' do
#    subscribe_probe(create(:proposal))
  end

  it 'experiencies can be subscribed' do
#    subscribe_probe(create(:experiencie))
  end

  def subscribe_probe(doc, url = nil)
    user = create(:user)
    login_user user

    url ||= [doc]

    visit polymorphic_path(url)
    follow_link = find_link('follow-document nofollow')
    puts follow_link.inspect
    follow_link.click


    doc.subscribers.count.must_equal 1
    doc.subscriptors.must_include user
  end
end
