class Content < ActiveRecord::Base
  include HasTranslations
  translates :title, :summary, :body

  include ActionView::Helpers::SanitizeHelper
  include HasPopularity

  extend FriendlyId
  friendly_id :title, use: [:slugged, :simple_i18n, :history]
  include HasTranslatedSlugs

  before_save :clean_input

  belongs_to :user
  belongs_to :group
  include HasSections
  include HasEditors

  scope :latest, limit(4)

  attr_accessible :user_id, :group_id
  attr_accessible :title, :body
  attr_accessible :published_at
  attr_accessible :embed, :image, :link_url
  attr_accessible :group, :user

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :slug, presence: true

  before_save :set_published_date

  private
  def set_published_date
    self.published_at ||= Time.now
  end

  def clean_input
    self.body = sanitize self.body, tags: %w(a p em strong), attributes: %(href)
  end
end
