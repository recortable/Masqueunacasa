# HasSpace
#
module HasSpace
  extend ActiveSupport::Concern

  included do
    expose(:group) { @space }
  end

  def group
    @space
  end

  protected
  def group_or_site_from_subdomain
    if request.subdomain.blank?
      @space = Site.new
    else
      @space = Group.find_by_slug(request.subdomain)
      if @space.blank?
        redirect_to error_url, :status => 404
      end
    end
  end
end
