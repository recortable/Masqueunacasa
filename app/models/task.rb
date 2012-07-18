class Task < ActiveRecord::Base
  attr_accessible :title, :finished
  delegate :title, to: :document, prefix: true

  belongs_to :document, polymorphic: true
  belongs_to :user

  has_paper_trail meta: { title: :document_title }

  def version_title
    title
  end

end
