require 'spec_helper'

describe 'Users integration' do
  it 'create users' do
    visit new_user_path
    fill_in 'user_name', with: 'NewUser'
    fill_in 'user_email', with: 'user@email.com'
    fill_in 'user_password', with: 'secret'
    fill_in 'user_password_confirmation', with: 'secret'
    click_submit 'commit_user'

    user = User.last
    expect( user.name ).to eq 'NewUser'
    expect( user.email ).to eq 'user@email.com'
  end
end
