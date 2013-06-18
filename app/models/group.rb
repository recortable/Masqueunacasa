class Group < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  include HasTranslations
  translates :title, :summary

  before_validation do |group|
    group.title = group.name if group.title.blank?
  end

  attr_accessible :name,
                  :title,
                  :email,
                  :avatar_image,
                  :summary,
                  :user_id,
                  :memberships_count,
                  :city, :country, :website, :twitter, :facebook
  store :settings, accessors: [:city, :country, :website,
                    :twitter, :facebook]

  validates :name, presence: true, uniqueness: true
  validates :title, presence: true
  validates :summary, presence: true
  include HasSections
  include HasLocation
  include HasPopularity


  default_scope order: 'updated_at ASC'

  belongs_to :user
  include HasMemberships

  mount_uploader :avatar_image, GroupAvatarUploader
end
