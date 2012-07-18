class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :imageable, polymorphic: true
  delegate :title, to: :imageable, prefix: true
  default_scope order: 'position ASC'
  attr_accessible :title, :image, :external_image_url
  validates :title, presence: true

  acts_as_list scope: [:imageable_type, :imageable_id]
  mount_uploader :image, ImageUploader
  has_paper_trail meta: { title: :title, parent_title: :imageable_title, document: :imageable }

  validates :title, presence: true
  validate :image_xor_external_image_url

  private

    def image_xor_external_image_url
      if (self.image.blank? && self.external_image_url.blank?)
        errors.add(:image, "Debes introducir al menos una fuentes para la imagen")
      end
      if (!self.image.blank? && !self.external_image_url.blank?)
        errors.add(:image, "No puedes introducir dos fuentes para la imagen")
      end
    end
end
