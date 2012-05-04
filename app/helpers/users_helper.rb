module UsersHelper
  def user_card(user, &block)
    content = block_given? ? capture(&block) : ''
    render partial: 'users/user', locals: {user: user, info: content}
  end
end
