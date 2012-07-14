class Agent < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :name, :title, :email
  attr_accessible :admin, :avatar_image
  attr_accessible :summary
  attr_accessible :lang
  attr_accessible :city, :country, :website, :twitter, :facebook
  store :settings, accessors: [:city, :country, :website, 
                    :twitter, :facebook]
  include Translatable
  translates :summary


  validates :name, presence: true, uniqueness: true

  include HasSections

  include HasLocations

  include HasPopularity


end
