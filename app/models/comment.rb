class Comment < ActiveRecord::Base
  include PublicActivity::Common

  attr_accessible :body

  before_create :set_locale

  belongs_to :document, polymorphic: true
  belongs_to :user

  validates :body, :user_id, :document_id, :document_type, presence: true

  default_scope order: 'created_at DESC'

  private

  def set_locale
    self.locale = T.l.to_s
  end
end
