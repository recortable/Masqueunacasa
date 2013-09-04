class Proposal < ActiveRecord::Base
  include PublicActivity::Common

  include HasTranslations
  translates :title, :description, :body, :summary

  extend FriendlyId
  friendly_id :title, use: [:slugged, :simple_i18n, :history]
  include HasTranslatedSlugs

  include HasComments

  acts_as_list scope: :category_id

  attr_accessible :user_id, :phase_id, :group_id, :category_id
  attr_accessible :user, :phase, :group, :category
  attr_accessible :title, :body, :description, :summary
  attr_accessible :published, :body_type
  attr_accessible :position

  validates_presence_of :title, :user, :category_id

  belongs_to :user
  belongs_to :group
  belongs_to :phase
  belongs_to :category, touch: true

  has_many :relations, dependent: :destroy
  has_many :experiencies, through: :relations

  include HasSections
  include HasPopularity
  include HasEditors
  include HasLinks

  scope :published, where(published: true)
  scope :all_for_phase, lambda {|phase|
    {
      joins: [:relations, :proposals],
      conditions: { proposals: { phase_id: phase.id }},
      select: "DISTINCT `experiencies`.*"
    }
  }

  before_save :add_phase
  after_save :propagate_category

  def add_relation(experiencie, user)
    Relation.create(user: user, proposal: self, experiencie: experiencie)
  end

  private
  def add_phase
    self.category.reload
    self.phase = self.category.phase
  end

  def propagate_category
    if self.category_id_changed?
      relations.each(&:save)
    end
  end
end
