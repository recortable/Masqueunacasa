require 'spec_helper'

describe "User sessions integration" do
  let( :user ) { create :user, password: 'secret' }

  it "users can sign in" do
    visit login_path
    fill_in 'user_session_email', with: user.email
    fill_in 'user_session_password', with: 'secret'
    click_submit
    user.reload
    expect( user.login_count).to eq 1
  end
end
