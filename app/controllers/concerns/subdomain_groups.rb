# SubdomainGroups
#
module SubdomainGroups
  extend ActiveSupport::Concern

  included do
    expose(:current_group) { @current_group }
  end

  protected
  def load_subdomain_group
    if request.subdomain.blank?
      @current_group = Site.new
    else
      @current_group = Group.find_by_slug(request.subdomain)
      if @current_group.blank?
        puts "Subdomain #{request.subdomain}"
        raise ActionController::RoutingError.new('Not Found')
      end
    end
  end
end
