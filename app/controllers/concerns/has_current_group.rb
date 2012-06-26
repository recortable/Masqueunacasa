# SubdomainGroups
#
module HasCurrentGroup
  extend ActiveSupport::Concern

  included do
    expose(:current_group) { load_subdomain_group }
    expose(:current_membership) { current_group.membership_for(current_user) }
    before_filter :clear_subdomain
  end

  protected
  def clear_subdomain
    subdomain = request.subdomain
    if subdomain == 'www' 
      redirect_to url_for(subdomain: false)
    elsif subdomain =~ /^www\..+/
      redirect_to url_for(subdomain: subdomain[4..-1])
    end
  end

  def load_subdomain_group
    subdomain = request.subdomain
    if subdomain.blank?
      current_group = Group.root
    else
      current_group = Group.find_by_subdomain(subdomain)
      if current_group.blank?
        puts "Subdomain #{subdomain}"
        raise ActionController::RoutingError.new("Group in subdomain #{subdomain} not found")
      end
      current_group
    end
  end
end
