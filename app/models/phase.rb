class Phase < ActiveRecord::Base
  include HasTranslations
  translates :title, :summary, :question

  extend FriendlyId
  friendly_id :title, use: [:simple_i18n, :history]
  include HasTranslatedSlugs

  attr_accessible :title, :question, :summary, :video

  validates_presence_of :title

  has_many :categories, order: :position
  has_many :proposals, order: 'kudos_count DESC, view_count DESC'
  include HasPopularity

  default_scope order: :position

  acts_as_list

  def experiencies
    pids = Proposal.where(phase_id: self.id).map(&:id)
    es = Relation.where(proposal_id: pids)
    es.map {|e| e.experiencie }
  end
end

