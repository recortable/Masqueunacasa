class Agent < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :name, :title, :email
  attr_accessible :admin, :avatar_image
  attr_accessible :lang
  attr_accessible :city, :country, :website, :twitter, :facebook
  store :settings, accessors: [:city, :country, :website, 
                    :twitter, :facebook]

  validates :name, presence: true, uniqueness: true

  has_many :locations, as: :resource, dependent: :destroy
  include HasSections

  include HasPopularity


end
