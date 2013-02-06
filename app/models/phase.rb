class Phase < ActiveRecord::Base
  translates :title, :summary, :question

  extend FriendlyId
  friendly_id :title, use: [:simple_i18n, :history]
  include HasTranslatedSlugs

  attr_accessible :title, :question, :summary
  attr_accessible :position, :color

  validates_presence_of :title

  has_many :categories, order: :position
  has_many :proposals, order: 'kudos_count DESC, view_count DESC'
  include HasPopularity
  include HasSections

  default_scope order: :position

  acts_as_list

  ICONS = ['organizacion', 'realizacion', 'uso']
  COLORS = ['az', 't', 'am']
  COLOR_NAMES = ['azul_gris', 'tierra', 'ocre']

  def color
    COLORS[(position - 1) % 3]
  end

  def color_name
    COLOR_NAMES[(position - 1) % 3]
  end

  def textura
    textura = ICONS[(position - 1) % 3]
    "textura_#{textura}"
  end

  # TODO: convertir en un campo de la db
  def image_url
    "habitap/#{icon}_100.png"
  end

  def icon
    ICONS[(position - 1) % 3]
  end

  def experiencies
    pids = Proposal.where(phase_id: self.id).map(&:id)
    es = Relation.where(proposal_id: pids)
    es.map {|e| e.experiencie }
  end
end
