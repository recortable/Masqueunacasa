class Category < ActiveRecord::Base
  include Translatable
  extend FriendlyId
  friendly_id :title, use: :simple_i18n
  acts_as_list scope: :phase_id

  translates :title, :slug, :question, :body
  translation_required :title, :slug, :question

  attr_accessible :title, :question, :body, :body_type
  attr_accessible :user_id, :user, :phase_id, :phase

  validates_presence_of :user_id, :phase_id, :title, :question

  belongs_to :user
  belongs_to :phase
  has_many :proposals, order: :position
  has_many :sections, as: :document, conditions: proc { ['lang = ?', I18n.locale] }
end
