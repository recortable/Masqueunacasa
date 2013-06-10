class Comment < ActiveRecord::Base
  attr_accessible :body

  belongs_to :document, polymorphic: true
  belongs_to :user

  validates :body, :user_id, :document_id, :document_type, presence: true

  default_scope order: 'created_at DESC'
end
