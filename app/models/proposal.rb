class Proposal < ActiveRecord::Base
  include Translatable
  extend FriendlyId
  friendly_id :title, use: :simple_i18n
  has_paper_trail meta: {title: :title, group_id: :group_id }

  translates :title, :body, :slug, :description
  translation_required :title, :slug

  attr_accessible :title_es, :body_es, :description_es
  attr_accessible :title_ca, :body_ca, :description_ca
  attr_accessible :user_id, :phase_id, :group_id, :category_id
  attr_accessible :user, :phase, :group, :category
  attr_accessible :title, :body, :description
  attr_accessible :published

  belongs_to :user
  belongs_to :group
  belongs_to :phase
  belongs_to :category

  validates_presence_of :title, :title_es, :title_ca, :user, :phase
  
  scope :published, where(published: true)

  # TODO: a la espera de subir imágenes
  def avatar_image?
    false
  end

end
