require 'test_helper'

describe HasSubscriptors do

  it 'can subscribe' do
    user = create(:user)
    doc = create(:phase)
    s = doc.subscribe(user)
    s.user.must_equal user
    s.document.must_equal doc
  end

  it 'check subscriptor' do
    user = create(:user)
    doc = create(:phase)
    doc.subscriptor?(user).must_equal false
    doc.subscribe(user)
    doc.subscriptor?(user).must_equal true
  end

  it 'has subscriptors' do
    user = create(:user)
    doc = create(:phase)

    doc.subscriptors.count.must_equal 0
    doc.subscribe(user)
    doc.subscriptors.count.must_equal 1
    doc.subscriptors.first.must_equal user
  end

  it 'ubsubcribe' do
    user = create(:user)
    doc = create(:phase)
    doc.unsubscribe(user).must_equal false
    doc.subscribe(user)
    doc.unsubscribe(user).wont_equal false
    doc.subscriptors.count.must_equal 0
  end
end
