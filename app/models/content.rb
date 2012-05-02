class Content < ActiveRecord::Base
  include Translatable
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  belongs_to :group

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
end
