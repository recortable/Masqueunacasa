class Phase < ActiveRecord::Base
  attr_accessible :title_es, :title_ca, :title
  attr_accessible :summary_es, :summary_ca, :summary
  attr_accessible :position

  validates_presence_of :title_es, :title_ca

  has_many :categories, order: :position
  has_many :proposals, order: 'kudos_count DESC, view_count DESC'
  include HasPopularity
  #include HasSubscriptors
  include HasSections

  default_scope order: :position

  include Translatable
  translates :title, :summary
  extend FriendlyId
  friendly_id :title, use: :simple_i18n
  acts_as_list

  ICONS = ['organizacion', 'realizacion', 'uso']
  # TODO: convertir en un campo de la db
  def image_url
    icon = ICONS[position - 1]
    "habitap/#{icon}_100.png"
  end

  def experiencies
    pids = Proposal.where(phase_id: self.id).map(&:id)
    es = Relation.where(proposal_id: pids)
    es.map {|e| e.experiencie }
  end
end
