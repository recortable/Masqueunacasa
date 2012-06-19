class Section < ActiveRecord::Base
  attr_accessible :document_id, :document_type
  attr_accessible :lang, :title, :body, :body_type

  validates_presence_of :document_id, :document_type, :lang, :body_type

  belongs_to :document, polymorphic: true, touch: true
  default_scope order: 'position ASC'
  scope :titled, where('title IS NOT NULL')

  acts_as_list scope: [:document_type, :document_id]
  has_paper_trail meta: {title: :document_title}
  delegate :title, to: :document, prefix: true
end
