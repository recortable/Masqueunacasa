require 'file_size_validator'

class PostAttachment < ActiveRecord::Base
  attr_accessible :file, :title

  validates_presence_of :user_id, :group_id, :post_id, :title, :file
  validates_uniqueness_of :title, scope: :group_id
  validates :file, file_size: { maximum: 4.megabytes.to_i }

  belongs_to :user
  belongs_to :group
  belongs_to :post

  mount_uploader :file, PostAttachmentUploader
  before_save :update_file_attributes

  private
  def update_file_attributes
    if file.present? && file_changed?
      self.content_type = file.file.content_type
      self.size = file.file.size
    end
  end

end
