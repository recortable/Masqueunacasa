module HasAuthRole
  extend ActiveSupport::Concern

  included do
    expose(:auth_role) { load_auth_role }
  end

  protected 
  def load_auth_role
    if current_user.blank?
      :anonymous
    elsif current_user.admin?
      :admin
    elsif current_group.site?
      :visitor
    else
      ms = current_group.memberships_for(user)
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
