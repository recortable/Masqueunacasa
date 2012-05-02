module CurrentUser
  extend ActiveSupport::Concern

  included do
   helper_method :current_user
  end

  def login_user(user, options = {bypass: false})
    session[:user_id] = user.id
    unless options[:bypass]
      user.login_count = user.login_count + 1
      user.last_login_at = Time.now
      user.save
    end
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = 'Es necesario que te identifiques primero.'
      redirect_to login_path(from: request.fullpath)
    end
  end

  def store_location(location = nil)
    location ||= request.fullpath
    session[:return_to] = location
  end

  def current_user
    @current_user ||= if session[:user_id].present?
      User.find session[:user_id]
    else
      nil
    end
  end

end
