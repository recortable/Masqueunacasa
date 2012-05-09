require 'test_helper'

describe 'Users integration' do
  it 'list users' do
    user = create(:user)
    visit users_path
    page.text.must_include user.name
  end

  it 'create users' do
    admin = create(:user, admin: true)
    login_user(admin)
    visit new_user_path
    page.fill_in 'user_name', with: 'NewUser'
    page.fill_in 'user_email', with: 'user@email.com'
    page.fill_in 'user_password', with: 'secret'
    page.fill_in 'user_password_confirmation', with: 'secret'
    click_submit
    user = User.last
    user.name.must_equal 'NewUser'
  end
end
