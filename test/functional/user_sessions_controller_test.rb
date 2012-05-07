require 'test_helper'

describe 'UserSessions integration' do

  it "creates user session" do
    user = create(:user, password: 'secret')
    visit login_path
    fill_in 'user_session_email', with: user.email
    fill_in 'user_session_password', with: 'secret'
    click_submit
    user.reload
    user.login_count.must_equal 1
  end
end
