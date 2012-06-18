class Section < ActiveRecord::Base
  attr_accessible :proposal_id
  attr_accessible :lang, :title, :body, :body_type

  validates_presence_of :proposal_id, :lang, :body_type

  belongs_to :proposal
  default_scope order: 'position ASC'

  acts_as_list scope: :proposal_id
  has_paper_trail meta: {title: :proposal_title }
  delegate :title, to: :proposal, prefix: true

end
