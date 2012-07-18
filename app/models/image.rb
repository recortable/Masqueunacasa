class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :imageable, polymorphic: true

  acts_as_list scope: [:imageable_type, :imageable_id]
  default_scope order: 'position ASC'

  attr_accessible :title, :image, :external_image_url

  mount_uploader :image, ImageUploader

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

    def should_have_external_image_url?
      self.image.blank?
    end
end
