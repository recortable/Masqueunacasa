module HasComments
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :document, dependent: :destroy
  end
end
