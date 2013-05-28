class Group < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  include HasTranslations
  translates :title, :summary


  attr_accessible :name, :title, :email
  attr_accessible :admin, :avatar_image
  attr_accessible :summary
  attr_accessible :lang
  attr_accessible :city, :country, :website, :twitter, :facebook
  attr_accessible :user_id, :memberships_count, :banner_image
  store :settings, accessors: [:city, :country, :website,
                    :twitter, :facebook]

  validates :name, presence: true, uniqueness: true
  validates :title, presence: true
  include HasSections
  include HasLocations
  include HasPopularity


  default_scope order: 'updated_at ASC'
  scope :community, where(admin: false)

  belongs_to :user
  include HasMemberships

  mount_uploader :banner_image, GroupBannerUploader
  mount_uploader :avatar_image, GroupAvatarUploader
end
