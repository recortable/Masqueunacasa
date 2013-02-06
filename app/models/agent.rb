class Agent < ActiveRecord::Base
  translates :summary

  attr_accessible :name, :title, :email
  attr_accessible :admin, :avatar_image
  attr_accessible :summary
  attr_accessible :lang
  attr_accessible :city, :country, :website, :twitter, :facebook
  store :settings, accessors: [:city, :country, :website,
                    :twitter, :facebook]

  validates :name, presence: true, uniqueness: true
  validates :title, presence: true
  include HasSections
  include HasLocations
  include HasPopularity
end
