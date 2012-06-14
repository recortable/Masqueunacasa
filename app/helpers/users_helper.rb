module UsersHelper
  def user_card(user, options = {}, &block)
    content = block_given? ? capture(&block) : ''
    options.reverse_merge(size: 'medium')
    options[:user] = user
    options[:info] = content
    render partial: 'users/user', locals: options
  end
end
