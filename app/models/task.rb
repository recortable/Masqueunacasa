class Task < ActiveRecord::Base
  attr_accessible :title, :finished
  delegate :title, to: :document, prefix: true

  validates :title, presence: true

  belongs_to :document, polymorphic: true
  belongs_to :user
  include DocumentHasEditors

  has_paper_trail meta: { title: :title, parent_title: :document_title, document: :document }

  def to_anchor
    title
  end
end
