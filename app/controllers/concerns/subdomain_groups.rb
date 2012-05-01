# SubdomainGroups
#
module SubdomainGroups
  extend ActiveSupport::Concern

  included do
    expose(:group) { @space }
  end

  def group
    @space
  end

  protected
  def load_subdomain_group
    if request.subdomain.blank?
      @space = Site.new
    else
      @space = Group.find_by_slug(request.subdomain)
      if @space.blank?
        raise ActionController::RoutingError.new('Not Found')
      end
    end
  end
end
