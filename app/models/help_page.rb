class HelpPage < ActiveRecord::Base
  attr_accessible :title,
                  :desctiption,
                  :summary

  extend FriendlyId
  friendly_id :title, use: [:slugged, :simple_i18n, :history]
  include HasTranslatedSlugs

  include HasSections

  include HasTranslations
  translates :title, :summary

  validates :title, presence: true
  validates :summary, presence: true
  validates :identf, presence: true, format: { with: /\A\w+\z/ },
    length: { maximum: 20 }

end
