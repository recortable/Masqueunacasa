require 'test_helper'

describe 'Users integration' do
  it 'list users' do
    user = create(:user)
    visit users_path
    page.text.must_include user.name
  end

  it 'create users' do
    visit new_user_path
    page.fill_in 'user_name', with: 'NewUser'
    page.fill_in 'user_title', with: 'User title'
    page.fill_in 'user_email', with: 'user@email.com'
    page.fill_in 'user_password', with: 'secret'
    page.fill_in 'user_password_confirmation', with: 'secret'
    click_submit 'commit_user'

    user = User.last
    user.name.must_equal 'NewUser'
    user.title.must_equal 'User title'
    user.email.must_equal 'user@email.com'
  end
end
