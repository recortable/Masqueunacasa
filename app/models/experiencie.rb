class Experiencie < ActiveRecord::Base
  include PublicActivity::Common

  include HasTranslations
  translates :title, :summary, :body

  extend FriendlyId
  friendly_id :title, use: [:slugged, :simple_i18n, :history]
  include HasTranslatedSlugs

  include HasComments

  attr_accessible :title, :body, :slug
  attr_accessible :summary
  attr_accessible :user_id, :group_id, :user, :group
  attr_accessible :published
  attr_accessible :images_attributes

  attr_accessible :related_proposal_id
  attr_accessor :related_proposal_id

  belongs_to :user
  belongs_to :group
  has_many :relations, dependent: :destroy
  has_many :proposals, through: :relations
  has_many :images, dependent: :destroy, as: :imageable
  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: proc { |attributes| attributes['image'].blank? &&
                      attributes['external_image_url'].blank? &&
                      attributes['image_cache'].blank? &&
                      attributes['new_object'] == 'true' }
  include HasLocation
  include HasPopularity
  include HasSections
  include HasLinks
  include HasEditors

  validates :title, presence: true, uniqueness: true

  scope :published, where(published: true)

  after_create :add_relations

  def image
    img = first_image
    return img.image.small unless img.nil?
  end

  def image_thumb
    img = first_image
    return img.image.thumb unless img.nil?
  end

  private

  def first_image
    images.first
  end

  def add_relations
    if related_proposal_id.present?
      puts "JOEDR #{related_proposal_id}"
      proposal = Proposal.find_by_id(related_proposal_id.to_i)
      proposal.add_relation(self, self.user)
    end
  end
end
