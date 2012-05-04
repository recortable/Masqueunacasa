module UsersHelper
  def user_card(user, &block)
    content = capture(&block)
    render partial: 'users/user', locals: {user: user, info: content}
  end
end
