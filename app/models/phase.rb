class Phase < ActiveRecord::Base
  attr_accessible :name_es, :description_es
  attr_accessible :name_ca, :description_ca
  attr_accessible :name, :description, :position

  has_many :categories, order: :position
  default_scope order: :position
  
  validates_presence_of :name_es, :name_ca

  include Translatable
  translates :name, :description
  extend FriendlyId
  friendly_id :name, use: :simple_i18n
end
