class Experiencie < ActiveRecord::Base
  include Translatable
  extend FriendlyId

  friendly_id :title, use: :simple_i18n
  has_paper_trail meta: { title: :title, group_id: :group_id }
  translates :title, :body, :slug, :summary
  translation_required :title, :slug

  attr_accessible :title, :body, :slug
  attr_accessible :summary
  attr_accessible :user_id, :group_id, :user, :group
  attr_accessible :published
  attr_accessible :title_ca, :body_ca, :slug_ca
  attr_accessible :title_es, :body_es, :slug_es

  attr_accessible :related_proposal_id
  attr_accessor :related_proposal_id
  
  belongs_to :user
  belongs_to :group
  has_many :relations, dependent: :destroy
  has_many :proposals, through: :relations
  include HasLocations
  include HasPopularity
  include HasSubscriptors
  include HasSections

  validates_presence_of :title, :user
  validates_uniqueness_of :title_es, :title_ca

  scope :published, where(published: true)

  after_create :add_relations

  # TODO: hacer que funcione para otros idiomas
  def self.search(term)
    Experiencie.where(Experiencie.arel_table[:title_es].matches("%#{term}%")).order('title_es ASC')
  end

  private
  def add_relations
    if related_proposal_id.present?
      proposal = Proposal.find related_proposal_id
      proposal.add_relation(self, self.user) 
    end
  end
end
