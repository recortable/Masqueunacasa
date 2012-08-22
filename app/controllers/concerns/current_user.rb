module CurrentUser
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
    before_filter :set_current_user
  end

  def login_user(user, options = {bypass: false})
    session[:user_id] = user.id
    unless options[:bypass]
      user.login_count ||= 0 
      user.login_count = user.login_count + 1
      user.last_login_at = Time.now
      user.save
    end
  end

  def require_user
    if current_user
      true
    else
      store_location
      flash[:notice] = 'Es necesario que te identifiques primero.'
      redirect_to login_path(from: request.fullpath)
      false
    end
  end

  def require_admin
    if require_user && current_user.admin?
      true
    else
      false
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

  protected
  def set_current_user
    User.current_user = self.current_user
  end

end
