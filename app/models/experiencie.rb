class Experiencie < ActiveRecord::Base
  include Translatable
  extend FriendlyId
  friendly_id :title, use: :simple_i18n
  has_paper_trail meta: { title: :title, group_id: :group_id }

  translates :title, :body, :slug
  translation_required :title, :slug

  attr_accessible :title, :body, :slug
  attr_accessible :user_id, :group_id, :user, :group
  attr_accessible :published
  attr_accessible :title_ca, :body_ca, :slug_ca
  attr_accessible :title_es, :body_es, :slug_es
  
  belongs_to :user
  belongs_to :group

  validates_presence_of :title, :user
  validates_uniqueness_of :title_es, :title_ca

  scope :published, where(published: true)

end
