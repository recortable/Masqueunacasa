class Phase < ActiveRecord::Base
  attr_accessible :title_es, :title_ca, :title
  attr_accessible :position

  validates_presence_of :title_es, :title_ca

  has_many :categories, order: :position
  has_many :proposals, order: 'kudos_count DESC, view_count DESC'
  has_many :sections, as: :document, conditions: proc { ['lang = ?', I18n.locale] }

  default_scope order: :position

  include Translatable
  translates :title
  extend FriendlyId
  friendly_id :title, use: :simple_i18n
  include HasPopularity
  include HasSubscriptors

  # TODO: convertir en un campo de la db
  def image_url
    "habitap/#{slug_es}.png"
  end
end
