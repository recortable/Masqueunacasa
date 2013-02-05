class Content < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper
  include Translatable
  include HasPopularity

  extend FriendlyId
  friendly_id :title, use: [:slugged, :simple_i18n, :history]

  has_paper_trail meta: {title: :title, group_id: :group_id }
  before_save :clean_input

  belongs_to :user
  belongs_to :group
  include HasSections
  include HasEditors

  scope :latest, limit(4)

  attr_accessible :user_id, :group_id
  attr_accessible :title, :body
  attr_accessible :title_es, :title_ca, :title_en
  attr_accessible :body_es, :body_ca, :body_en
  attr_accessible :published_at
  attr_accessible :embed, :image, :link_url
  attr_accessible :group, :user

  translates :title, :body

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
