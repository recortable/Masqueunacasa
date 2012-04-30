# HasSpace
#
module HasSpace
  extend ActiveSupport::Concern

  included do
    before_filter :load_space
    expose(:group) { @space }
  end
  
  def group
    @space
  end

  protected
  def load_space
    @space = Group.find_by_slug(request.subdomain)
    if @space.blank?
      redirect_to root_url(subdomain: false), notice: 'Grupo no encontrado' 
    end
  end
end
