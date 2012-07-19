module HasLinks
  extend ActiveSupport::Concern

  included do
    has_many :links, as: :document, dependent: :destroy
  end

  def add_link(link, user)
    link.document = self
    link.user = user
    link.save ? link : nil
  end

end
