class Proposal < ActiveRecord::Base
  has_paper_trail meta: {title: :title, group_id: :group_id }
  acts_as_list scope: :category_id
  extend FriendlyId
  friendly_id :title, use: :simple_i18n
  include HasPopularity
  include HasSubscriptors
  include Translatable
  translates :title, :body, :slug, :description
  translation_required :title, :slug

  attr_accessible :title_es, :body_es, :description_es
  attr_accessible :title_ca, :body_ca, :description_ca
  attr_accessible :user_id, :phase_id, :group_id, :category_id
  attr_accessible :user, :phase, :group, :category
  attr_accessible :title, :body, :description
  attr_accessible :published, :body_type

  validates_presence_of :title, :title_es, :title_ca, :user, :phase_id, :category_id

  belongs_to :user
  belongs_to :group
  belongs_to :phase
  belongs_to :category
  has_many :relations, dependent: :destroy
  has_many :experiencies, through: :relations 
  include HasSections

  
  scope :published, where(published: true)

  # TODO: a la espera de subir imágenes
  def avatar_image?
    false
  end

  def add_relation(experiencie, user)
    Relation.create(user: user, proposal: self, experiencie: experiencie)
  end
end
