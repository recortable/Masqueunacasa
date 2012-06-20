class Phase < ActiveRecord::Base
  attr_accessible :title_es, :title_ca, :title
  attr_accessible :position

  validates_presence_of :title_es, :title_ca

  has_many :categories, order: :position
  default_scope order: :position
  has_many :sections, as: :document, conditions: proc { ['lang = ?', I18n.locale] }

  include Translatable
  translates :title
  extend FriendlyId
  friendly_id :title, use: :simple_i18n
end
