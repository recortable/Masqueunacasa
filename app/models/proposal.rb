class Proposal < ActiveRecord::Base
  include Translatable
  extend FriendlyId
  translates :title, :body, :slug
  friendly_id :title, use: :simple_i18n
  before_validation :clone_locale

  attr_accessible :title_es, :body_es
  attr_accessible :title_ca, :body_ca
  attr_accessible :user_id, :phase_id, :group_id
  attr_accessible :user, :title, :body
  attr_accessible :published

  belongs_to :user
  belongs_to :group

  validates_presence_of :title, :title_es, :title_ca, :user_id
  
  scope :published, where(published: true)

  # TODO: a la espera de subir imágenes
  def avatar_image?
    false
  end

  protected
  def clone_locale
    self.title_es ||= self.title
    self.title_ca ||= self.title
    self.slug_es ||= self.slug
    self.slug_ca ||= self.slug
  end
end
