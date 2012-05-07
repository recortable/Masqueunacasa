module HasAuthRole
  extend ActiveSupport::Concern

  included do
    expose(:auth_role) { load_auth_role }
    expose(:current_auth) { load_current_auth }
    helper_method :can?
  end

  protected 
  def can?(method, model)
    current_auth.can?(method, model)
  end

  def authorize!(method, model)
    unless current_auth.can?(method, model)
      raise Authorizations::AccessDenied.new
    end
  end


  def load_current_auth
    "Authorizations::#{auth_role.to_s.camelcase}".constantize.new
  end

  def load_auth_role
    if current_user.blank?
      :anonymous
    elsif current_user.admin?
      :admin
    elsif current_group.site?
      :visitor
    else
      ms = current_group.membership_for(current_user)
      if ms.blank?
        :visitor
      elsif ms.state == 'owner'
        :admin
      elsif ms.state == 'member'
        :member
      else
        :visitor
      end
    end
  end
end
