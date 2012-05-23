class Phase < ActiveRecord::Base
  include Translatable
  extend FriendlyId
  friendly_id :name, use: :simple_i18n

  translates :name, :description
  attr_accessible :name_es, :description_es
  attr_accessible :name_ca, :description_ca
  attr_accessible :name, :description, :position

  validates_presence_of :name_es, :name_ca

  has_many :categories
end
