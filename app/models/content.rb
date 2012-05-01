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

  translates :title, :body

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :slug, presence: true
end
