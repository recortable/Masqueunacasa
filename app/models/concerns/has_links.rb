module HasLinks
  extend ActiveSupport::Concern

  included do
    has_many :links, as: :resource, dependent: :destroy
  end

  def add_link(link, user)
    link.resource = self
    link.user = user
    link.save ? link : nil
  end

end
