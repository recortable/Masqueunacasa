# SubdomainGroups
#
module HasCurrentGroup
  extend ActiveSupport::Concern

  included do
    expose(:current_group) { load_subdomain_group }
  end

  protected
  def load_subdomain_group
    if request.subdomain.blank?
      Site.new
    else
      current_group = Group.find_by_slug(request.subdomain)
      if current_group.blank?
        puts "Subdomain #{request.subdomain}"
        raise ActionController::RoutingError.new("Group in subdomain #{request.subdomain} not found")
      end
      current_group
    end
  end
end
