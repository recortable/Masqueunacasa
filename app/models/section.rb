require 'file_size_validator'

class Section < ActiveRecord::Base
  attr_accessible :group_id
  attr_accessible :document_id, :document_type
  attr_accessible :lang, :title, :body, :body_type
  attr_accessible :image
  attr_accessible :image_position
  delegate :title, to: :document, prefix: true

  validates_presence_of :document_id, :document_type, :lang, :body_type
#  validates :image, file_size: { maximum: 1.megabytes.to_i }

  belongs_to :group
  belongs_to :document, polymorphic: true, touch: true

  default_scope order: 'position ASC'
  scope :titled, where("title <> ''")

  acts_as_list scope: [:document_type, :document_id]
  has_paper_trail meta: {title: :to_anchor, parent_title: :document_title, document: :document}
  include DocumentHasEditors

  mount_uploader :image, ImageUploader
  store :properties, accessors: [:image_position]
  before_save :update_group_id

  def to_anchor
    title.present? ? title : position.to_s
  end

  protected
  def update_group_id
    if document_id_changed?
      if document_type == 'Group'
        self.group_id = document_id
      elsif document.respond_to?(:group_id)
        self.group_id = document.group_id
      end
    end
  end
end
